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

source_checksum=595d311ad117e41ad908b7065743917542b40f343d1334673e98171ee74d36e6

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
  core/gcc
)

pkg_deps=(
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

do_download() {
  do_default_download

  download_file https://github.com/commercialhaskell/stack/archive/v${pkg_version}.tar.gz source_archive.tar.gz ${source_checksum}
}

do_clean() {
  do_default_clean

  # Strip any previous stack/cabal config/cache
  rm -rf /root/.stack
  rm -rf /root/.cabal
}

do_unpack() {
  do_default_unpack

  mkdir -p source_archive
  tar zxf source_archive.tar.gz --strip-components=1 -C source_archive
}

do_build() {
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for libiconv)/lib:$(pkg_path_for gcc)/lib"
  export SYSTEM_CERTIFICATE_PATH="$(pkg_path_for cacerts)/ssl"
  ln -sfv "$(pkg_path_for iana-etc)/etc/protocols" /etc

  cabal sandbox init
  cabal update

  cabal install  \
    --extra-include-dirs=$(pkg_path_for zlib)/include \
    --extra-lib-dirs=$(pkg_path_for zlib)/lib

  # Stage 2 stack bootstrap
  pushd $HAB_CACHE_SRC_PATH/source_archive

  $HAB_CACHE_SRC_PATH/$pkg_dirname/.cabal-sandbox/bin/stack setup \
    --system-ghc --stack-yaml=stack-8.0.yaml

  $HAB_CACHE_SRC_PATH/$pkg_dirname/.cabal-sandbox/bin/stack build \
    --system-ghc --stack-yaml=stack-8.0.yaml \
    --extra-include-dirs=$(pkg_path_for zlib)/include \
    --extra-lib-dirs=$(pkg_path_for zlib)/lib

  popd
}

do_install() {
  pushd $HAB_CACHE_SRC_PATH/source_archive

  $HAB_CACHE_SRC_PATH/$pkg_dirname/.cabal-sandbox/bin/stack install --local-bin-path "$pkg_prefix/bin" --copy-bins \
    --system-ghc --stack-yaml=stack-8.0.yaml \
    --extra-include-dirs=$(pkg_path_for zlib)/include \
    --extra-lib-dirs=$(pkg_path_for zlib)/lib

  popd
}

do_end() {
  rm -fv /etc/protocols
}