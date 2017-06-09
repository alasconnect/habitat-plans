# THIS WAS A FAILED EXPIREMENT
pkg_name=ghcjs-stack
pkg_origin=alasconnect
pkg_version=0.2.1.9007015
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/ghcjs/ghcjs
pkg_description="GHCJS is a Haskell to JavaScript compiler that uses the GHC API. Built for stack integration."
pkg_source=http://ghcjs.tolysz.org/ghc-8.0-2017-01-11-lts-7.15-9007015.tar.gz
pkg_shasum=a62a0a8d3370da2753aeef0e1b36d5c8e63d164fd8c71df83b6e3aa78ed4a272
pkg_dirname=ghcjs-${pkg_version}
pkg_bin_dirs=(bin)

ghc_version=8.0.1

pkg_build_deps=(
  alasconnect/ghc/${ghc_version}
  alasconnect/haskell-stack
  core/gcc
  core/iana-etc
  core/cacerts
  core/coreutils
)

pkg_deps=(
  core/gcc-libs
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
)

do_clean() {
  do_default_clean

  rm -rf /root/.stack
  rm -rf /root/.cabal
}

do_build() {
  # Setup /usr/bin/env as ghcjs compile looks for it
  ln -sfv "$(pkg_path_for coreutils)"/bin/env /usr/bin/env

  # Stack needs protocols for TCP
  ln -sfv "$(pkg_path_for iana-etc)/etc/protocols" /etc

  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for gcc)/lib"
  export SYSTEM_CERTIFICATE_PATH="$(pkg_path_for cacerts)/ssl"

  stack setup --system-ghc
  stack build --system-ghc
}

do_install() {
  stack install --system-ghc --local-bin-path "$pkg_prefix/bin" --copy-bins
}

do_end() {
  rm -fv /etc/protocols
  rm -fv /usr/bin/env
}
