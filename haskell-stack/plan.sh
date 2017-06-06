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
  core/git
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/zlib
  core/glibc
)

do_clean() {
  do_default_clean

  # Strip any previous stack config/cache
  rm -rf /root/.stack
}

do_build() {
  cabal sandbox init
  cabal update

  attach
  cabal install --extra-include-dirs=$(pkg_path_for core/zlib)/include --extra-lib-dirs=$(pkg_path_for core/zlib)/lib
}

do_install() {
  attach
}
