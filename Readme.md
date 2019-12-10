Find Mimimum Index 
------------------------------------
Testing various implementation of finding the index of the minimum element in an array.
- "C" style
- "STL" style
- Using SSE2/SSE4.1 intrinsics 
- Using AVX2 intrinsics

Clang example output
--------------------
```
2019-12-10 02:05:38
Running ./mybenchmark
Run on (8 X 2500 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
Load Average: 2.07, 1.71, 1.36
-----------------------------------------------------------------------
Benchmark                             Time             CPU   Iterations
-----------------------------------------------------------------------
findMinimumIndexC_mean             1631 ns         1630 ns           40
findMinimumIndexC_median           1621 ns         1620 ns           40
findMinimumIndexC_stddev           34.3 ns         33.3 ns           40
findMinimumIndexSTL_mean            953 ns          952 ns           40
findMinimumIndexSTL_median          946 ns          945 ns           40
findMinimumIndexSTL_stddev         18.2 ns         17.5 ns           40
findMinimumIndexSSE_4_mean          831 ns          829 ns           40
findMinimumIndexSSE_4_median        826 ns          825 ns           40
findMinimumIndexSSE_4_stddev       18.9 ns         17.9 ns           40
findMinimumIndexSSE_8_mean          606 ns          605 ns           40
findMinimumIndexSSE_8_median        600 ns          599 ns           40
findMinimumIndexSSE_8_stddev       16.0 ns         15.2 ns           40
```




