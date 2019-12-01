Gaussian Sum Filter KL helpers
-----------------------------

Looking at ways of making the relevant method of the ATLAS software 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/src/KLGaussianMixtureReduction.cxx
faster

The AlignedDynArray is taken from : 
https://gitlab.cern.ch/atlas/athena/blob/master/Tracking/TrkFitter/TrkGaussianSumFilter/TrkGaussianSumFilter/AllignedDynArray.h

Find Mimimum Index 
------------------------------------

- gcc : https://godbolt.org/z/Tmg7N-
- clang : https://godbolt.org/z/CnGXk5

Calculate All Distances
---------------------------

- gcc : https://godbolt.org/z/fbPT8d
- clang : https://godbolt.org/z/gYwGjb
