hkg_name=primitive
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=0.6.2.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/haskell/primitive
pkg_description="This package provides various primitive memory-related operations."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=b8e8d70213e22b3fab0e0d11525c02627489618988fdc636052ca0adce282ae1
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
