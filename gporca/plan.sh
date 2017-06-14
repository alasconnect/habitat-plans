pkg_name=gporca
pkg_origin=alasconnect
pkg_version=2.32.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('Apache-2.0')
pkg_upstream_url=http://greenplum.org/
pkg_description="The Greenplum Next Generation Query Optimizer."
pkg_source=https://github.com/greenplum-db/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=0164ccc14722c71b3aab841f2ce06ffb6afa656e1707b5b3796ec2c5272187e7

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/curl
  core/openssl
  core/zlib
  alasconnect/gp-xerces
)

pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils
  core/cmake
)

do_build() {
  cmake -D CMAKE_INSTALL_PREFIX:PATH="${pkg_prefix}" \
    -D XERCES_LIBRARY="$(pkg_path_for gp-xerces)/lib/libxerces-c.so" \
    -D XERCES_INCLUDE_DIR="$(pkg_path_for gp-xerces)/include" \
    .

  make
}
