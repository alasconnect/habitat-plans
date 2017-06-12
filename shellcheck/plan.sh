pkg_name=shellcheck
hkg_name=ShellCheck
pkg_origin=alasconnect
pkg_version=0.4.6
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('GPL-3')
pkg_upstream_url=http://www.shellcheck.net/
pkg_description="ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts"
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=11eb9b2794363fbccc6fbd18601db49680e2c439440a9b103eebfda1aa86b1bc
pkg_dirname=${hkg_name}-${pkg_version}

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

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

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  cabal sandbox init
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
