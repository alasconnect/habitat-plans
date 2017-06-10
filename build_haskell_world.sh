#!/bin/bash
# Helper script to build out the whole haskell library set
set -e
# build ghc
# build cabal-install

plan_list=(
  # haskell/mtl
  # haskell/primitive
  # haskell/random
  # haskell/tf-random
  # haskell/quickcheck
  # happy
  # alex
  haskell/text
  haskell/syb
  haskell/json
)

results=()

for plan in "${plan_list[@]}"
do
  hab pkg build -R ${plan}
  source results/last_build.env
  results+=("${pkg_artifact}")
  # hab pkg upload "results/${pkg_artifact}"
done


echo "Results: "
for artifact in "${results[@]}"
do
  echo "${artifact}"
done

# hab pkg build -R ghcjs
