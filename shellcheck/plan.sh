pkg_name=shellcheck
hkg_name=ShellCheck
pkg_origin=alasconnect
pkg_version=0.4.7
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('GPL-3')
pkg_upstream_url="http://www.shellcheck.net/"
pkg_description="ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts"
pkg_source="https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz"
pkg_shasum="184955264d42c5dca0300fb9688b9a6c9a1c70c345dbcd8e30bb48a049a70d7c"
pkg_dirname="${hkg_name}-${pkg_version}"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

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

  # Strip any previous cabal config
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
