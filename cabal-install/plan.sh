pkg_name=cabal-install
pkg_origin=alasconnect
pkg_version=2.0.0.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/cabal/
pkg_description="Command-line interface for Cabal and Hackage"
pkg_source=https://www.haskell.org/cabal/release/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz
pkg_shasum=f991e36f3adaa1c7e2f0c422a2f2a4ab21b7041c82a8896f72afc9843a0d5d99

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/zlib
  core/glibc
)

pkg_build_deps=(
  alasconnect/ghc82
  core/curl
  core/which
  core/sed
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  EXTRA_CONFIGURE_OPTS="--extra-include-dirs=$(pkg_path_for zlib)/include --extra-lib-dirs=$(pkg_path_for zlib)/lib" ./bootstrap.sh --sandbox
}

do_check() {
  # Validate the sandbox build
  .cabal-sandbox/bin/cabal update
  .cabal-sandbox/bin/cabal info cabal
}

do_install() {
  cp -f .cabal-sandbox/bin/cabal $pkg_prefix/bin
}
