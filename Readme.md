Gaussian Sum Filter KL helpers
-----------------------------

Looking at ways of making the relevant method of the ATLAS software 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/src/KLGaussianMixtureReduction.cxx
faster

The AlignedDynArray is taken from : 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/TrkGaussianSumFilter/AllignedDynArray.h

Find Mimimum Index 
------------------------------------


- gcc : https://godbolt.org/z/JAjnMg
- clang : https://godbolt.org/z/_ETHXf

Here the compiler and the exact system/options seems to play quite an important role



Calculate All Distances
---------------------------

- gcc : https://godbolt.org/z/fbPT8d
- clang : https://godbolt.org/z/gYwGjb

Both seem to produce some SSE instructions even in -02
