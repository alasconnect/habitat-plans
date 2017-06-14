pkg_name=hlint
pkg_origin=alasconnect
pkg_version=2.0.8
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/ndmitchell/hlint#readme
pkg_description="HLint is a tool for suggesting possible improvements to Haskell code."
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=5fd875f191da00203fadb3be773d79b2ebb7f0aabc6cf7406c9c8d90a4a7bcfd

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
  core/gcc-libs
  alasconnect/happy
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config/cache
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for core/gcc-libs)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
