pkg_name=vault
pkg_origin=alasconnect
pkg_version=0.9.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MPL-2.0')
pkg_upstream_url=https://www.vaultproject.io/
pkg_description="A tool for managing secrets. Binary package only."
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/vault_${pkg_version}_linux_amd64.zip
pkg_shasum=6308013ee0d6278e98cdfe8d6de0162102a8d25f3bcd1e3737bf7b022a9f6702
pkg_filename=${pkg_name}-${pkg_version}_linux_amd64.zip

pkg_bin_dirs=(bin)

pkg_deps=()

pkg_build_deps=(
  core/unzip
)

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D vault "${pkg_prefix}"/bin/vault
}
