Find Mimimum Index of array
------------------------------------

Looking at ways of making the relevant method of the ATLAS software 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/src/KLGaussianMixtureReduction.cxx
that uses
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/TrkGaussianSumFilter/AllignedDynArray.h
to use SSE

inspired by
http://0x80.pl/notesen/2018-10-03-simd-index-of-min.html

Compiler Explorer
------------------
- gcc : https://godbolt.org/z/8sx5aC
- clang : https://godbolt.org/z/gQ29VC
