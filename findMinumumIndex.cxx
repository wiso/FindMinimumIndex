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
size_t findMinimumIndexC(float* __restrict arrayIn, int n){  
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);
  float minimum = array[0]; 
  size_t minIndex=0;
  for (int i=0 ; i<n ; ++i){
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
size_t findMinimumIndexCPP(float* __restrict arrayIn, int n){  
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);
  return std::distance(array, std::min_element(array, array+n));
}


#if defined(__SSE4_1__) || defined(__SSE2__) 


#if defined(__SSE4_1__) 
#warning ( "SSE 4_1" )
#include <smmintrin.h>

#elif defined(__SSE2__)
#warning ( "SSE_2" )
#include <emmintrin.h> 
static inline __m128i SSE2_mm_blendv_epi8(__m128i a, __m128i b, __m128i mask) {
  return _mm_or_si128(_mm_andnot_si128(mask, a), _mm_and_si128(mask, b));
}

const auto _mm_blendv_epi8 = SSE2_mm_blendv_epi8;
#endif //on SSE4.1 vs SSE2


size_t findMinimumIndexSSE(float* __restrict arrayIn, int n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  /* 
   * SIMD part
   */
  const __m128i increment = _mm_set1_epi32(4);
  __m128i indices         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i minindices      = indices;
  __m128 minvalues       = _mm_load_ps(array);

  for (int i=4; i<n; i+=4) {
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

size_t findMinimumIndexSSEUnRoll(float* __restrict arrayIn, int n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  /* 
   * SIMD part
   */
  const __m128i increment = _mm_set1_epi32(4);
  __m128i indices         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i minindices      = indices;
  __m128 minvalues       = _mm_load_ps(array);
  for (int i=0; i<n; i+=16) {
    //Load 16 elements at a time 
    const __m128 values0   = _mm_load_ps(array+i);  
    const  __m128 values1  = _mm_load_ps(array+i+4); //second 4
    const  __m128 values2  = _mm_load_ps(array+i+8); //second 4
    const  __m128 values3  = _mm_load_ps(array+i+12); //second 4
    //0
    __m128i lt     = _mm_castps_si128 (_mm_cmplt_ps(values0, minvalues));//compare with previous minvalues/create mask
    minindices = _mm_blendv_epi8(minindices, indices, lt);//blend with mask to get updated indices
    minvalues  = _mm_min_ps(values0, minvalues);//get new min values
    indices = _mm_add_epi32(indices, increment);//increment indices
    //1
    lt    = _mm_castps_si128 (_mm_cmplt_ps(values1, minvalues));//compare with previous minvalues/create mask
    minindices = _mm_blendv_epi8(minindices, indices, lt);//blend with mask to get updated indices 
    minvalues  = _mm_min_ps(values1, minvalues);//get new min values
    indices = _mm_add_epi32(indices, increment);//increment indices
    //2
    lt     = _mm_castps_si128 (_mm_cmplt_ps(values2, minvalues));//compare with previous minvalues/create mask
    minindices = _mm_blendv_epi8(minindices, indices, lt);//blend with mask to get updated indices
    minvalues  = _mm_min_ps(values2, minvalues);//get new min values
    indices = _mm_add_epi32(indices, increment);//increment indices
    //3
    lt     = _mm_castps_si128 (_mm_cmplt_ps(values3, minvalues));//compare with previous minvalues/create mask
    minindices = _mm_blendv_epi8(minindices, indices, lt);//blend with mask to get updated indices
    minvalues  = _mm_min_ps(values3, minvalues);//get new min values
    indices = _mm_add_epi32(indices, increment);//increment indices
  }
  /*
   * Do the final calculation scalar way since this is 
   * only 4 can be perhaps done a bit better
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

size_t findMinimumIndexSSE16(float* __restrict arrayIn, int n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  /* 
   * SIMD part
   */
  
  const __m128i increment = _mm_set1_epi32(16);
  __m128i indices1         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i indices2         = _mm_setr_epi32(4, 5, 6, 7);
  __m128i indices3         = _mm_setr_epi32(8, 9, 10, 11);
  __m128i indices4         = _mm_setr_epi32(12, 13, 14, 15);

  __m128i minindices1      = indices1;
  __m128i minindices2      = indices2;
  __m128i minindices3      = indices3;
  __m128i minindices4      = indices3;
  
  __m128 minvalues1       = _mm_load_ps(array);
  __m128 minvalues2       = _mm_load_ps(array+4);
  __m128 minvalues3       = _mm_load_ps(array+8);
  __m128 minvalues4       = _mm_load_ps(array+12);
  
  for (int i=16; i<n; i+=16) {
    //Load 16 elements at a time 
    const __m128 values1   = _mm_load_ps(array+i);  
    const  __m128 values2  = _mm_load_ps(array+i+4); //second 4
    const  __m128 values3  = _mm_load_ps(array+i+8); //third 4
    const  __m128 values4  = _mm_load_ps(array+i+12); //fourth 4
     //1
    indices1 = _mm_add_epi32(indices1, increment);//increment indices
    __m128i lt1 = _mm_castps_si128 (_mm_cmplt_ps(values1, minvalues1));//compare with previous minvalues/create mask
     minindices1 = _mm_blendv_epi8(minindices1, indices1, lt1);//blend with mask to get updated indices
     minvalues1  = _mm_min_ps(values1, minvalues1);//get new min values
     //2
    indices2 = _mm_add_epi32(indices2, increment);//increment indices
    __m128i lt2 = _mm_castps_si128 (_mm_cmplt_ps(values2, minvalues2));//compare with previous minvalues/create mask
     minindices2 = _mm_blendv_epi8(minindices2, indices2, lt2);//blend with mask to get updated indices
     minvalues2  = _mm_min_ps(values2, minvalues2);//get new min values
    //3
    indices3 = _mm_add_epi32(indices3, increment);//increment indices
    __m128i lt3 = _mm_castps_si128 (_mm_cmplt_ps(values3, minvalues3));//compare with previous minvalues/create mask
     minindices3 = _mm_blendv_epi8(minindices3, indices3, lt3);//blend with mask to get updated indices
     minvalues3  = _mm_min_ps(values3, minvalues3);//get new min values
    //4
     indices4 = _mm_add_epi32(indices4, increment);//increment indices
    __m128i lt4 = _mm_castps_si128 (_mm_cmplt_ps(values4, minvalues4));//compare with previous minvalues/create mask
     minindices4 = _mm_blendv_epi8(minindices4, indices4, lt4);//blend with mask to get updated indices
     minvalues4  = _mm_min_ps(values4, minvalues4);//get new min values
  }
  /*
   * Do the final calculation scalar way since this is 
   * only 4 can be perhaps done a bit better
   */
  float  finalValues[16];
  int32_t finalIndices[16];
  _mm_storeu_ps(finalValues,minvalues1);
  _mm_storeu_ps(finalValues+4,minvalues2);
  _mm_storeu_ps(finalValues+8,minvalues3);
  _mm_storeu_ps(finalValues+12,minvalues4);
  _mm_storeu_si128((__m128i*)(finalIndices), minindices1);
  _mm_storeu_si128((__m128i*)(finalIndices+4), minindices2);
  _mm_storeu_si128((__m128i*)(finalIndices+8), minindices3);
  _mm_storeu_si128((__m128i*)(finalIndices+12), minindices4);
  
  size_t  minindex = finalIndices[0];
  float  minvalue = finalValues[0];
  for (size_t i=1; i < 16; ++i) {
    if (finalValues[i] < minvalue) {
      minvalue = finalValues[i];
      minindex = finalIndices[i];
    }    
  }
  return minindex;
}



#else
#warning( "NO SSE" )
#endif //On SSE vs No SSE

int main(){
  /*
   * Fill array with random numbers
   */
  //std::random_device rd;
  //std::mt19937 gen(rd()); 
  std::mt19937 gen; 
  std::uniform_real_distribution<> dis(1.0, 10.0);
  const size_t n= 72;
  const size_t initnn= n*(n+1)/2;
  const size_t nn = ( 16* round(initnn /16. ));

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
    //Test simple SSE solution
    std::cout << "-- findMinimumIndexSSE ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexSSE(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';
  //4.
  { 
    //Test simple SSE unroll solution
    std::cout << "-- findMinimumIndexSSEUnRoll ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexSSEUnRoll(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';
  //5.
  { 
    //Test simple SSE unroll solution
    std::cout << "-- findMinimumIndexSSE16 ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexSSE16(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';


}
