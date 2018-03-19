pkg_name=ghc710
pkg_origin=alasconnect
pkg_version=7.10.3
patched_version=7.10.3b
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/ghc/
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${patched_version}-src.tar.xz
pkg_shasum=06c6c20077dc3cf7ea3f40126b2128ce5ab144e1fa66fd1c05ae1ade3dfaa8e5
pkg_dirname=ghc-${pkg_version}

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(lib/ghc-${pkg_version}/include)

pkg_deps=(
  core/perl
  core/gcc
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libedit
  core/libffi
  core/libiconv
  alasconnect/ncurses
)

pkg_build_deps=(
  alasconnect/ghc710-bootstrap
  core/make
  core/diffutils
  core/sed
  core/patch
)

do_prepare() {
  do_default_prepare

  cp mk/build.mk.sample mk/build.mk
  sed -i '1iBuildFlavour = quick' mk/build.mk
}

do_build() {
  # FIXME: Having some difficulty building 7.10.3 from source. Currently bootstrapping 7.10.3 binary to 8.0.x source
  # Getting linker errrors with libffi
  # Setting these paths is only necessary when building from a binary bootstrap
  export LIBRARY_PATH="${LIBRARY_PATH}:${LD_RUN_PATH}"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${LD_RUN_PATH}"

  libffi_include=$(find $(pkg_path_for libffi)/lib/ -name "libffi-*.*.*")

  if [ -z "${libffi_include}" ]; then
    echo "libffi_include not found, exiting"
    exit 1
  fi

  ./configure \
    --prefix="${pkg_prefix}" \
    --with-system-libffi \
    --with-ffi-libraries="$(pkg_path_for libffi)/lib" \
    --with-ffi-includes="${libffi_include}/include" \
    --with-curses-includes="$(pkg_path_for ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for gmp)/lib" \
    --with-iconv-includes="$(pkg_path_for libiconv)/include" \
    --with-iconv-libraries="$(pkg_path_for libiconv)/lib"

  make
}
