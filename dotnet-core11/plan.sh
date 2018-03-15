pkg_name=dotnet-core11
pkg_origin=alasconnect
pkg_version=1.1.10
pkg_license=('MIT')
pkg_upstream_url="https://www.microsoft.com/net/core"
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/${pkg_version}/dotnet-debian-x64.${pkg_version}.tar.gz"
pkg_shasum="6435eee4f30392b8b951e4aa297aa374ca8e0e5a7e7b26c5504872c95db3f0eb"
pkg_filename="dotnet-debian-x64.${pkg_version}.tar.gz"
pkg_deps=(
  core/curl
  core/gcc-libs
  core/glibc
  core/icu52
  core/krb5
  core/libunwind
  core/lttng-ust
  core/openssl
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/patchelf
)
pkg_bin_dirs=(bin)

do_unpack() {
  # Extract into $pkg_dirname instead of straight into $HAB_CACHE_SRC_PATH.
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  tar xfz "$HAB_CACHE_SRC_PATH/$pkg_filename" -C "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  find -type f -name 'dotnet' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix/bin"
  chmod o+r -R "$pkg_prefix/bin"
}

do_strip() {
  return 0
}
