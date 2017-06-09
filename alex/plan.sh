pkg_name=alex
pkg_origin=alasconnect
pkg_version=3.2.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/jtdaugherty/dbmigrations-postgresql
pkg_description="Alex is a tool for generating lexical analysers in Haskell. It takes a description of tokens based on regular expressions and generates a Haskell module containing code for scanning text efficiently. It is similar to the tool lex or flex for C/C++."
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a4e7f7ec729f4fae5a5c778bc48421a90acf65c7278f6970cf123fb3b6230e6c
pkg_bin_dirs=(bin)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
  core/gcc
)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for core/gcc)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
