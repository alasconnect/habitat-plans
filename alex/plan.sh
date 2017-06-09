pkg_name=alex
pkg_origin=alasconnect
pkg_version=3.2.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=http://www.haskell.org/alex/
pkg_description="Alex is a tool for generating lexical analysers in Haskell. It takes a description of tokens based on regular expressions and generates a Haskell module containing code for scanning text efficiently. It is similar to the tool lex or flex for C/C++."
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a4e7f7ec729f4fae5a5c778bc48421a90acf65c7278f6970cf123fb3b6230e6c

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/happy
  alasconnect/haskell-quickcheck
)

do_build() {
  runhaskell Setup.lhs configure --prefix=${pkg_prefix}

  runhaskell Setup.lhs build
}

do_install() {
  runhaskell Setup.lhs install
}
