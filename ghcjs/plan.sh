pkg_name=ghcjs
pkg_origin=alasconnect
pkg_version=0.2.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/ghcjs/ghcjs
pkg_description="GHCJS is a Haskell to JavaScript compiler that uses the GHC API."
pkg_source=http://ghcjs.luite.com/ghc-8.0-20170610.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=73441475c05d428ca877167e460e99729f7feaf985d4f544ef22d7d3746cde3d

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

ghc_version=8.0.2

pkg_deps=(
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  alasconnect/ncurses
  core/node
)

pkg_build_deps=(
  alasconnect/ghc/${ghc_version}
  alasconnect/cabal-install
  core/gcc
  core/coreutils
  alasconnect/happy
  alasconnect/alex
  # core/git
  # core/make
  # core/autoconf
)

do_clean() {
  do_default_clean

  rm -rf /root/.cabal
}

do_build() {
  # Setup /usr/bin/env as ghcjs compile looks for it
  ln -sfv "$(pkg_path_for coreutils)"/bin/env /usr/bin/env

  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for gcc)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
  # attach
  # $pkg_prefix/bin/ghcjs-boot \
  #   --with-gmp-includes="$(pkg_path_for gmp)/include" \
  #   --with-gmp-libraries="$(pkg_path_for gmp)/lib" \
  #   --with-iconv-includes="$(pkg_path_for libiconv)/include" \
  #   --with-iconv-libraries="$(pkg_path_for libiconv)/lib"
}

do_end() {
  rm -fv /usr/bin/env
}
