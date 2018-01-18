pkg_name=postgresql
pkg_version=9.6.3
pkg_origin=alasconnect
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')

pkg_deps=(
  core/bash
  core/postgresql/${pkg_version}
)

pkg_build_deps=()

pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)

pkg_exposes=(port)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user


do_build() {
  return 0
}

do_install() {
  return 0
}
