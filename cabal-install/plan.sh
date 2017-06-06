pkg_name=cabal-install
pkg_origin=alasconnect
pkg_version=1.24.0.2
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/cabal/
pkg_description="Command-line interface for Cabal and Hackager"
pkg_source=https://www.haskell.org/cabal/release/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz
pkg_shasum=2ac8819238a0e57fff9c3c857e97b8705b1b5fef2e46cd2829e85d96e2a00fe0
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_build_deps=(
  core/curl
  core/which
  core/gcc
  core/sed
  core/vim
)

pkg_deps=(
  alasconnect/ghc
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libedit
  core/libffi
  core/libiconv
  core/ncurses
  core/zlib
)

do_build() {
  # sed -i s/'$CC -print-prog-name=$link'/'$CC -print-prog-name=$link && break'/ bootstrap.sh
  attach
  ./bootstrap.sh --sandbox
}

# do_check() {
#   make test
# }
