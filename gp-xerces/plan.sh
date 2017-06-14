pkg_name=gp-xerces
pkg_origin=alasconnect
pkg_version=3.1.2-p1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('Apache-2.0')
pkg_upstream_url=http://greenplum.org/
pkg_description="Greenplum patched xerces-c in order to compile GPORCA"
pkg_source=https://github.com/greenplum-db/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=ffc69798257a3e3885e0096e3eefd910a59f23731eb77dea92c87df210bc8227

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/curl
  core/zlib
  core/openssl
)

pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils
  core/diffutils
  core/file
)

do_prepare() {
  _file_path="$(pkg_path_for file)/bin/file"
  sed -e "s#/usr/bin/file#${_file_path}#g" -i configure
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --with-curl="$(pkg_path_for curl)/lib"

  make
}
