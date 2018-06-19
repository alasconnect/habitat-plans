pkg_name=alex
pkg_origin=alasconnect
pkg_version=3.2.3
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url="http://www.haskell.org/alex/"
pkg_description="Alex is a tool for generating lexical analysers in Haskell. It takes a description of tokens based on regular expressions and generates a Haskell module containing code for scanning text efficiently. It is similar to the tool lex or flex for C/C++."
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="1a63791417b3e6e36e8b79849317beeaf9ea09efa21bea021c2347b49266212e"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/glibc
  core/gmp
  core/libffi
)

pkg_build_deps=(
  alasconnect/ghc82
  alasconnect/cabal-install
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config/cache
  rm -rf /root/.cabal
}

do_build() {
  cabal sandbox init
  cabal update

  # Install dependencies
  cabal install --only-dependencies

  # Configure and Build
  cabal configure --prefix="$pkg_prefix"
  cabal build
}

do_install() {
  cabal copy
}
