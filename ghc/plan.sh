pkg_name=ghc
pkg_origin=alasconnect
pkg_version=8.0.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/ghc/
pkg_description="The Glasgow Haskell Compiler"
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz
pkg_shasum=90fb20cd8712e3c0fbeb2eac8dab6894404c21569746655b9b12ca9684c7d1d2
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_build_deps=(
  jarvus/ghc
  core/make
  core/diffutils
  core/sed
  core/python
  core/patch
)

pkg_deps=(
  core/perl
  core/gcc
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libedit
  core/libffi
  core/libiconv
  core/ncurses
)

do_build() {
  export LIBRARY_PATH="${LIBRARY_PATH}:${LD_RUN_PATH}"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${LD_RUN_PATH}"

  libffi_include=$(find $(pkg_path_for core/libffi)/lib/ -name "libffi-*.*.*")

  if [ -z "${libffi_include}" ]; then
    echo "libffi_include not found, exiting"
    exit 1
  fi

  ./configure \
    --prefix="${pkg_prefix}" \
    --with-system-libffi \
    --with-ffi-libraries="$(pkg_path_for core/libffi)/lib" \
    --with-ffi-includes="${libffi_include}/include" \
    --with-curses-includes="$(pkg_path_for core/ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for core/ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for core/gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for core/gmp)/lib" \
    --with-iconv-includes="$(pkg_path_for core/libiconv)/include" \
    --with-iconv-libraries="$(pkg_path_for core/libiconv)/lib"

  make
}

# do_check() {
#   make test
# }
