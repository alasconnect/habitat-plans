# NOTE: This plan is not ready. For now, use haskell-stack-bin
# Details: https://gist.github.com/wduncanfraser/0d53bd51fcacc59211c16f4186727c62
# TODO: Figure out what is going on
pkg_name=haskell-stack
pkg_origin=alasconnect
pkg_version=1.4.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskellstack.org/
pkg_description="Stack is a cross-platform program for developing Haskell projects."
pkg_source=https://github.com/commercialhaskell/stack/releases/download/v${pkg_version}/stack-${pkg_version}-sdist-0.tar.gz
pkg_shasum=edad1b32eb44acc7632a6b16726cd634f74383fd1c05757dccca1744d1ca3642
pkg_dirname=stack-${pkg_version}
pkg_bin_dirs=(bin)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
)

pkg_deps=(
  core/gcc
  core/glibc
  core/make
  core/xz
  core/perl
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/zlib
  core/git
  core/gnupg
  core/iana-etc
  core/cacerts
)

do_clean() {
  return 0
  do_default_clean

  # Strip any previous stack/cabal config/cache
  rm -rf /root/.stack
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for core/libiconv)/lib:$(pkg_path_for core/gcc)/lib"
  export SYSTEM_CERTIFICATE_PATH="$(pkg_path_for core/cacerts)/ssl"
  ln -sfv "$(pkg_path_for core/iana-etc)/etc/protocols" /etc

  cabal sandbox init
  cabal update

  cabal install  \
    --extra-include-dirs=$(pkg_path_for core/zlib)/include \
    --extra-lib-dirs=$(pkg_path_for core/zlib)/lib

  attach
  # Stage 2 stack bootstrap
  .cabal-sandbox/bin/stack setup --system-ghc --stack-yaml=stack-8.0.yaml
}

do_install() {
  attach
  cabal install --prefix="$pkg_prefix"
}
