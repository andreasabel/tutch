Tutch -- The tutorial proof checker
===================================

Checks Fitch-style proofs and proof terms for propositional and first-order logic and arithmetic.

Originally developed in 2000 for [CMU course 15-399](https://www.cs.cmu.edu/~fp/courses/15317-f00/)
*Constructive Logic*.

Homepage: https://www.cse.chalmers.se/~abela/tutch/

Building with SML/NJ
--------------------

You need package `smlnj` installed and `sml` in the `PATH`.

    make tutch-sml

This creates Tutch as a heap image and a script `bin/tutch` that will invoke `sml` with
this heap image.

Building with MLton
-------------------

You need package `mlton` installed and `mlton` in the `PATH`.
MLton must be [recent enough (2015-11-10)](http://mlton.org/Changelog) to support the
[`allowSigWithtype` annotation](http://mlton.org/MLBasisAnnotations) to allow
[`withtype` in signatures](http://mlton.org/SuccessorML#SigWithtype).

    make tutch-mlton

This creates the binary `bin/tutch`.

Test the build
--------------

    make test
