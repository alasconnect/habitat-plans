pkg_name=bind
pkg_origin=alasconnect
pkg_version=9.11.2
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MPL-2.0')
pkg_upstream_url=https://www.isc.org/software/bind/
pkg_description="BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users."
pkg_source=https://ftp.isc.org/isc/bind9/${pkg_version}/bind-${pkg_version}.tar.gz
pkg_shasum=7f46ad8620f7c3b0ac375d7a5211b15677708fda84ce25d7aeb7222fe2e3c77a
pkg_dirname=bind-${pkg_version}

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
