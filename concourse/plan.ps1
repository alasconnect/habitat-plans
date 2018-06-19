$pkg_name="concourse"
$pkg_origin="alasconnect"
$pkg_version="3.13.0"
$pkg_license=('Apache-2.0')
$pkg_upstream_url="https://concourse.ci"
$pkg_description="CI that scales with your project"
$pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
$pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_windows_amd64.exe"
$pkg_shasum="c734722b73d74f6920152b4152a6500fbc4ae65ca481b682cc619f6b958822a5"
$pkg_filename="${pkg_name}.exe"

$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/" -Force
}
