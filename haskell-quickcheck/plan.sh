hkg_name=QuickCheck
pkg_name=haskell-quickcheck
pkg_origin=alasconnect
pkg_version=2.9.2
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/nick8325/quickcheck
pkg_description="QuickCheck is a library for random testing of program properties."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=155c1656f583bc797587846ee1959143d2b1b9c88fbcb9d3f510f58d8fb93685
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
  alasconnect/haskell-random
  alasconnect/haskell-tf-random
)

do_build() {
  runhaskell Setup configure --prefix=${pkg_prefix} -O \
    --enable-library-profiling \
    --enable-shared

  runhaskell Setup build
}

do_install() {
  runhaskell Setup install
}
