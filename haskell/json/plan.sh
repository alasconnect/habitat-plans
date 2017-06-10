hkg_name=json
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=0.9.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/haskell/random
pkg_description="This library provides a parser and pretty printer for converting between Haskell values and JSON."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=96b57e4d167e45dc80aeff872a922ae9cdb953a1ded29ebbb51019b68f0085a2
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
  alasconnect/haskell-mtl
  alasconnect/haskell-syb
  alasconnect/haskell-text
)

do_build() {
  attach
  runhaskell Setup configure --prefix=${pkg_prefix} -O \
    --enable-library-profiling \
    --enable-shared \
    -f-mapdict -fgeneric -fpretty -f-parsec -fsplit-base

  runhaskell Setup build
}

do_install() {
  runhaskell Setup install
}
