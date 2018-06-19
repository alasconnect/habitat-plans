pkg_name=bind910
pkg_origin=alasconnect
pkg_version=9.10.6-P1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MPL-2.0')
pkg_upstream_url="https://www.isc.org/software/bind/"
pkg_description="BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users."
pkg_source="https://ftp.isc.org/isc/bind9/${pkg_version}/bind-${pkg_version}.tar.gz"
pkg_shasum="9b8b4f6ecfc82a491774bf713d8a888b954c427526035eb715544438f36a2334"
pkg_dirname="bind-${pkg_version}"

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/perl
  core/glibc
  core/openssl
  core/libxml2
  core/libtool
  core/zlib
)

pkg_build_deps=(
  core/gcc
  core/make
)


do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --sbindir="${pkg_prefix}/bin" \
    --localstatedir="${pkg_svc_var_path}" \
    --sysconfdir="${pkg_svc_config_path}" \
    --with-libtool \
    --with-libxml2="$(pkg_path_for libxml2)" \
    --with-openssl="$(pkg_path_for openssl)"

  make
}
