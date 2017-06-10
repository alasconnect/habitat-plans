hkg_name=text
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=1.2.2.2
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-2-Clause')
pkg_upstream_url=https://github.com/bos/text
pkg_description="An efficient packed, immutable Unicode text type (both strict and lazy), with a powerful loop fusion optimization framework."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=31465106360a7d7e214d96f1d1b4303a113ffce1bde44a4e614053a1e5072df9
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
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
