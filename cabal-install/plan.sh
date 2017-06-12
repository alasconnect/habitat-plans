pkg_name=cabal-install
pkg_origin=alasconnect
pkg_version=1.24.0.2
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/cabal/
pkg_description="Command-line interface for Cabal and Hackage"
pkg_source=https://www.haskell.org/cabal/release/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz
pkg_shasum=2ac8819238a0e57fff9c3c857e97b8705b1b5fef2e46cd2829e85d96e2a00fe0

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/zlib
  core/glibc
)

pkg_build_deps=(
  alasconnect/ghc
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
  # In reference to https://github.com/haskell/cabal/issues/3440 we have both ld and collect2 on the system,
  # it breaks the bootstrap script and the resolution to the above issue has not made it to release yet.
  # Manually applying patch that resolves issue.
  sed -i '72 c\          $CC -print-prog-name=$link && break' bootstrap.sh

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
