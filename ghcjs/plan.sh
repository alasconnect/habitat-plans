pkg_name=ghcjs
pkg_origin=alasconnect
commit_hash=7361890
pkg_version=0.2.1-${commit_hash}
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/ghcjs/ghcjs
pkg_description="GHCJS is a Haskell to JavaScript compiler that uses the GHC API."
pkg_source=https://api.github.com/repos/ghcjs/ghcjs/tarball/${commit_hash}
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=bddc12c4f0630bd1ae6bb854b5a1e0d2c51cc6ae7f566c5478437f1a514a8d42
pkg_dirname=ghcjs-ghcjs-${commit_hash}

pkg_bin_dirs=(bin)

ghc_version=8.0.2

pkg_deps=(
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  alasconnect/ncurses
)

pkg_build_deps=(
  alasconnect/ghc/${ghc_version}
  alasconnect/cabal-install
  core/gcc
  core/coreutils
  alasconnect/happy
  alasconnect/alex
)

do_clean() {
  return 0
  do_default_clean

  rm -rf /root/.cabal
}

do_build() {
  # Setup /usr/bin/env as ghcjs compile looks for it
  ln -sfv "$(pkg_path_for coreutils)"/bin/env /usr/bin/env

  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for core/gcc)/lib"

  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  attach
  cabal install --prefix="$pkg_prefix"
}

do_end() {
  rm -fv /usr/bin/env
}