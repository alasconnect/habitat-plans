pkg_name=dbmigrations-mysql
pkg_origin=alasconnect
pkg_version=2.0.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://github.com/jtdaugherty/dbmigrations"
pkg_description="The dbmigrations tool built for MySQL databases"
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="45bd44c9e46bff2923634030ea6f54b9df93ef3b2ea38749c5263f7e00421f5c"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gcc-libs
  core/glibc
  core/gmp
  core/libffi
  core/mysql
  core/openssl
  core/pcre
  core/zlib
)

pkg_build_deps=(
  alasconnect/ghc82
  alasconnect/cabal-install
  core/pkg-config
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  cabal sandbox init
  cabal update

  # Install dependencies
  cabal install --only-dependencies \
    --extra-lib-dirs=$(pkg_path_for openssl)/lib

  # Configure and Build
  cabal configure --prefix="$pkg_prefix"
  cabal build
}

do_install() {
  cabal copy
}
