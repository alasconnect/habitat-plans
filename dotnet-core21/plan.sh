pkg_name=dotnet-core21
pkg_origin=alasconnect
pkg_version=2.1.7
pkg_license=('MIT')
pkg_upstream_url="https://www.microsoft.com/net/core"
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/${pkg_version}/dotnet-runtime-${pkg_version}-linux-x64.tar.gz"
pkg_shasum="ca749b62bac83b79ddd064bf5fe74eaaeffaaf598afac4d34e0855e87d57b57f"
pkg_filename="dotnet-runtime-${pkg_version}-linux-x64.tar.gz"
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
