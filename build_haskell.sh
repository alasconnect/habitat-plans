#!/bin/sh
set -e
# build ghc

build haskell-mtl
build haskell-primitive
build haskell-random
build haskell-tf-random
build haskell-quickcheck
build happy
build alex

build ghcjs
