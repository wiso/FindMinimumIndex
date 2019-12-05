#include <stdlib.h>
#include <algorithm>
#include <random>
#include <chrono>
#include <iostream>

/*
 * Alignement of  64 bytes  
 */
constexpr int alignment=64;
/* 
 * Scalar code kind of C style 
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
/* 
 * Scalar code using STL  
 */
size_t findMinimumIndexCPP(float* __restrict arrayIn, int n){  
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);
  return std::distance(array, std::min_element(array, array+n));
}

/*
 * Hanlde the _mm_blendv_epi8 
 * for SSE2 only
 */
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

/*
 * SSE 4 elemets at a time
 */
size_t findMinimumIndexSSE4(float* __restrict arrayIn, int n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
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
   */
  alignas(alignment) float  finalValues[4];
  alignas(alignment) int32_t finalIndices[4];
  _mm_store_ps(finalValues,minvalues);
  _mm_store_si128((__m128i*)finalIndices, minindices);

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

/*
 * SSE 8 elements at time
 */
size_t findMinimumIndexSSE8(float* __restrict arrayIn, int n) {
  float* array = (float*)__builtin_assume_aligned(arrayIn, alignment);  
  const __m128i increment = _mm_set1_epi32(8);

  __m128i indices1         = _mm_setr_epi32(0, 1, 2, 3);
  __m128i indices2         = _mm_setr_epi32(4, 5, 6, 7);

  __m128i minindices1      = indices1;
  __m128i minindices2      = indices2;

  __m128 minvalues1       = _mm_load_ps(array);
  __m128 minvalues2       = _mm_load_ps(array+4);

  for (int i=8; i<n; i+=8) {
    //Load 8 elements at a time 
    const __m128 values1   = _mm_load_ps(array+i);  
    const  __m128 values2  = _mm_load_ps(array+i+4); //second 4
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
  }
  /*
   * Do the final calculation scalar way 
   */
  alignas(alignment) float  finalValues[8];
  alignas(alignment) int32_t finalIndices[8];
  _mm_store_ps(finalValues,minvalues1);
  _mm_store_ps(finalValues+4,minvalues2);
  _mm_store_si128((__m128i*)(finalIndices), minindices1);
  _mm_store_si128((__m128i*)(finalIndices+4), minindices2);

  size_t  minindex = finalIndices[0];
  float  minvalue = finalValues[0];
  for (size_t i=1; i < 8; ++i) {
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
  const size_t nn = ( 8* round(initnn /8. ));
  float* array;
  size_t const size = nn * sizeof(float);                                                                     
  //create buffer of right size,properly aligned                                                                      
  posix_memalign((void**) &array, alignment, size);         
  for (size_t i = 0; i < nn; ++i) {
    // Use dis to transform the random unsigned int generated by gen into a
    // double. Each call to dis(gen) generates a new random double
    array[i]=dis(gen);
  }

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
    //Test SSE4 solution
    std::cout << "-- findMinimumIndexSSE4 ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexSSE4(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';
  //4
  { 
    //Test SSE8 solution
    std::cout << "-- findMinimumIndexSSE8 ---" <<'\n'; 
    //Time it
    std::chrono::steady_clock::time_point clock_begin = std::chrono::steady_clock::now(); 
    auto index=findMinimumIndexSSE8(array,nn);
    std::chrono::steady_clock::time_point clock_end = std::chrono::steady_clock::now();
    std::chrono::steady_clock::duration diff = clock_end - clock_begin;
    //print 
    std::cout <<"Time: " << std::chrono::duration <double, std::nano> (diff).count() << "ns" << '\n';
    std::cout << "Minimum index " << index <<  " with value " <<array[index]<<'\n'; 
  }
  std::cout<<'\n';

 free(array);
}
