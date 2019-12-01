Find Mimimum Index of array
------------------------------------

Looking at ways of making the relevant method of the ATLAS software 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/src/KLGaussianMixtureReduction.cxx
to actually use SSE2

The AlignedDynArray is taken from : 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/TrkGaussianSumFilter/AllignedDynArray.h

The SSE part is inspired by 
http://0x80.pl/notesen/2018-10-03-simd-index-of-min.html

Compiler Explorer tests
----------------------
- gcc : https://godbolt.org/z/Tmg7N-
- clang : https://godbolt.org/z/CnGXk5
