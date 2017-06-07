# NOTE: This plan is not ready. For now, use haskell-stack-bin
# Details: https://gist.github.com/wduncanfraser/0d53bd51fcacc59211c16f4186727c62
# TODO: Figure out what is going on
pkg_name=haskell-stack
pkg_origin=alasconnect
pkg_version=1.4.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskellstack.org/
pkg_description="Stack is a cross-platform program for developing Haskell projects."
pkg_source=https://github.com/commercialhaskell/stack/archive/v${pkg_version}.tar.gz
pkg_shasum=595d311ad117e41ad908b7065743917542b40f343d1334673e98171ee74d36e6
pkg_dirname=stack-${pkg_version}
pkg_bin_dirs=(bin)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
)

pkg_deps=(
  core/gcc
  core/glibc
  core/make
  core/xz
  core/perl
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/zlib
  core/git
  core/gnupg
)

do_clean() {
  do_default_clean

  # Strip any previous stack/cabal config/cache
  rm -rf /root/.stack
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for core/libiconv)/lib:$(pkg_path_for core/gcc)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies --extra-include-dirs=$(pkg_path_for core/zlib)/include --extra-lib-dirs=$(pkg_path_for core/zlib)/lib

  attach
  cabal configure --extra-include-dirs=$(pkg_path_for core/zlib)/include --extra-lib-dirs=$(pkg_path_for core/zlib)/lib
  cabal build
  #cabal install --extra-include-dirs=$(pkg_path_for core/zlib)/include --extra-lib-dirs=$(pkg_path_for core/zlib)/lib
}

do_install() {
  #TBD
  attach
}
