pkg_name=happy
pkg_origin=alasconnect
pkg_version=1.19.5
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/happy/
pkg_description="Happy is a parser generator for Haskell. Given a grammar specification in BNF, Happy generates Haskell code to parse the grammar. Happy works in a similar way to the yacc tool for C."
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=62f03ac11d7b4b9913f212f5aa2eee1087f3b46dc07d799d41e1854ff02843da

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config/cache
  rm -rf /root/.cabal
}

do_build() {
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
