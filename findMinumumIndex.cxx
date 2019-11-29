#include <stdlib.h>
#include <algorithm>
#include <random>
#include <chrono>
#include <iostream>

/*
 * Alignement of 32 bytes  
 */
constexpr int alignment=32;



/* Aligned Dyn Array */
template<typename T,int Alignment>
class AlignedDynArray
{
public:
  AlignedDynArray() = delete;
  AlignedDynArray(AlignedDynArray const&) = delete;
  AlignedDynArray& operator=(AlignedDynArray const&) = delete;
  AlignedDynArray(AlignedDynArray&&) = delete;
  AlignedDynArray& operator=(AlignedDynArray&&) = delete;

  explicit AlignedDynArray(size_t n);
  ~AlignedDynArray();

  ///conversions to T*
  operator T*(); 
  operator const T*() const; 

  /// index array operators  
  T& operator [](const std::size_t pos);
  const T& operator [](const std::size_t pos) const ;

  ///size of allocated buffer
  std::size_t size() const;

private:
  T*  m_buffer=nullptr;
  void* m_raw=nullptr;
  size_t const m_size=0;
}; 

template<typename T, int Alignment>
inline
AlignedDynArray<T,Alignment>::AlignedDynArray(size_t n): m_buffer(nullptr), 
  m_raw(nullptr),
  m_size(n){
    size_t const size = n * sizeof(T) +alignof(T) ;
    //create buffer of right size,properly aligned
    posix_memalign(&m_raw, Alignment, size);
    //placement new of elements to the buffer
    m_buffer = new (m_raw) T[n];
  }

template<typename T, int Alignment>
inline  
AlignedDynArray<T,Alignment>::~AlignedDynArray(){
  for (std::size_t pos = 0; pos < m_size; ++pos) {
    m_buffer[pos].~T();
  }
  free(m_buffer);
}

template<typename T, int Alignment>
inline   
AlignedDynArray<T,Alignment>::operator T*() {return m_buffer;} 

template<typename T, int Alignment>
inline   
AlignedDynArray<T,Alignment>::operator const T*() const {return m_buffer;}

template<typename T, int Alignment>
inline  
T& AlignedDynArray<T,Alignment>::operator[] (const std::size_t pos) { return m_buffer[pos];}

template<typename T, int Alignment>
inline  
const T& AlignedDynArray<T,Alignment>::operator[] (const std::size_t pos) const { return m_buffer[pos];}

template<typename T, int Alignment>
inline  
std::size_t AlignedDynArray<T,Alignment>::size() const {return m_size;}
/* end of AlignedDynArray*/

/* 
 * Scalar code kind of C style 
 * Seem to runs the same when using gcc/clang -O2 
 */
static inline size_t findMinimumIndexC(float* __restrict arrayIn, const size_t n){  
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);
  float minimum = array[0]; 
  size_t minIndex=0;
  for (size_t i=0 ; i<n ; ++i){
    const float value = array[i]; 
    if(value<minimum){
      minimum=value;
      minIndex=i;
    }     
  }
  return minIndex;
} 

/* Scalar code using STL  
 * Seem to be faster than the C-style above for clang -O2
 * and slower for gcc -O2  
 */
static inline size_t findMinimumIndexCPP(float* __restrict arrayIn, const size_t n){  
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);
  return std::distance(array, std::min_element(array, array+n));
}


#if defined(__SSE4_1__)
#warning ( "SSE 4_1" )
#include <smmintrin.h>

size_t findMinimumIndexSSE4(float* __restrict arrayIn, const size_t n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  /* 
   * SIMD part
   */
  const __m128i increment = _mm_set1_epi32(4);
  __m128i indices         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i minindices      = indices;
  __m128 minvalues       = _mm_load_ps(array);

  for (size_t i=4; i<n; i+=4) {
    indices = _mm_add_epi32(indices, increment);//increment indices
    const __m128 values        = _mm_load_ps((array + i));//load new values
    const __m128i lt            = _mm_castps_si128 (_mm_cmplt_ps(values, minvalues));//compare with previous minvalues/create mask
    minindices = _mm_blendv_epi8(minindices, indices, lt);
    minvalues  = _mm_min_ps(values, minvalues);
  }
  /*
   * do the final calculation scalar way
   * store in arrays of 4 elemenrs and do the std implementation
   */
  float  finalValues[4];
  int32_t finalIndices[4];
  _mm_storeu_ps(finalValues,minvalues);
  _mm_storeu_si128((__m128i*)finalIndices, minindices);
  
  size_t  minindex = finalIndices[0];
  float  minvalue = finalValues[0];
  for (size_t i=1; i < 4; ++i) {
    const float value = finalValues[i];  
    if (value < minvalue) {
      minvalue = value;
      minindex = finalIndices[i];
    }    
  }
  return minindex;
}
const auto findMinIndex =findMinimumIndexSSE4;

#elif defined(__SSE2__)
#warning ( "SSE_2" )
/*
 * SSE2 alone 
 */
#include <emmintrin.h> 
/* Condiotion-less branch / blendv for SSE2*/
static inline __m128i SSE2_mm_blendv_epi8(__m128i a, __m128i b, __m128i c) {
  return _mm_or_si128(_mm_andnot_si128(c, a), _mm_and_si128(c, b));
}
size_t findMinimumIndexSSE2(float* __restrict arrayIn, const size_t n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  /* 
   * SIMD part
   */
  const __m128i increment = _mm_set1_epi32(4);
  __m128i indices         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i minindices      = indices;
  __m128 minvalues       = _mm_load_ps(array);

  for (size_t i=4; i<n; i+=4) {
    indices = _mm_add_epi32(indices, increment);//increment indices
    const __m128 values        = _mm_load_ps((array + i));//load new values
    const __m128i lt            = _mm_castps_si128 (_mm_cmplt_ps(values, minvalues));//compare with previous minvalues/create mask
    minindices = SSE2_mm_blendv_epi8(minindices, indices, lt);
    minvalues  = _mm_min_ps(values, minvalues);
  }
  /*
   * do the final calculation scalar way
   * store in arrays of 4 elemenrs and do the std implementation
   */
  float  finalValues[4];
  int32_t finalIndices[4];
  _mm_storeu_ps(finalValues,minvalues);
  _mm_storeu_si128((__m128i*)finalIndices, minindices);
  
  size_t  minindex = finalIndices[0];
  float  minvalue = finalValues[0];
  for (size_t i=1; i < 4; ++i) {
    const float value = finalValues[i];  
    if (value < minvalue) {
      minvalue = value;
      minindex = finalIndices[i];
    }    
  }
  return minindex;
}
const auto findMinIndex =findMinimumIndexSSE2;
#else
#warning( "NO SSE" )
const auto findMinIndex =findMinimumIndexC;
#endif



int main(){
  /*
   * Fill array with random numbers
   */
  //std::random_device rd;
  //std::mt19937 gen(rd()); 
  std::mt19937 gen; 
  std::uniform_real_distribution<> dis(1.0, 10.0);
  std::uniform_int_distribution<> disint(70, 80);
  const size_t n= disint(gen);
  const size_t initnn= n*(n-1)/2;
  const size_t nn = ( 4* round(initnn /4. ));

  AlignedDynArray<float,alignment> array(nn);
  for (size_t i = 0; i < nn; ++i) {
    // Use dis to transform the random unsigned int generated by gen into a
    // double. Each call to dis(gen) generates a new random double
    array[i]=dis(gen);
  }

  std::cout << "Using array of size "<< array.size() <<'\n';
  std::cout<<"addr of 0 % alignment " <<reinterpret_cast<uintptr_t>(&array[0]) % alignment<< " == 0 " <<'\n';
  std::cout<<"addr of 0"  <<reinterpret_cast<uintptr_t>(&array[0]) <<'\n';
  std::cout<<"addr of 1" <<reinterpret_cast<uintptr_t>(&array[1]) <<'\n';
  std::cout<<"addr of 2" <<reinterpret_cast<uintptr_t>(&array[2]) <<'\n';
  std::cout<<"addr of 3" <<reinterpret_cast<uintptr_t>(&array[3]) <<'\n';
  {
    auto index=findMinimumIndexC(array,nn);
    std::cout<<"position is " << index <<'\n';
  }
  std::cout<<'\n';

  //Test all styles below 
  //1.
  { 
    //Test simple C-style solution
    std::cout << "-- findMinimumIndexC ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexC(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';
  //2.
  { 
    std::cout << "--  findMinimumIndexCPP  ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now();
    auto index=findMinimumIndexCPP(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';
  //3.
  { 
    //Test simple C-style solution
    std::cout << "-- findMinIndex ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinIndex(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';

}
