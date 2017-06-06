pkg_name=haskell-stack
pkg_origin=alasconnect
pkg_version=1.4.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskellstack.org/
pkg_description="Stack is a cross-platform program for developing Haskell projects."
pkg_source=https://github.com/commercialhaskell/stack/archive/v${pkg_version}.tar.gz
pkg_shasum=595d311ad117e41ad908b7065743917542b40f343d1334673e98171ee74d36e6
pkg_bin_dirs=(bin)

pkg_build_deps=(
  alasconnect/ghc
)

pkg_deps=(
  core/git
)

do_build() {
  attach
}

do_install() {
  attach
}
