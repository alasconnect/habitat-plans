hkg_name=random
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=1.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/haskell/random
pkg_description="This package provides a basic random number generation library, including the ability to split random number generators."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=b718a41057e25a3a71df693ab0fe2263d492e759679b3c2fea6ea33b171d3a5a
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
