pkg_name=dbmigrations-postgresql
pkg_origin=alasconnect
pkg_version=2.0.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://github.com/jtdaugherty/dbmigrations"
pkg_description="The dbmigrations tool built for PostgreSQL databases"
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="fcf753778e2e071c8fa452c585b93c27c973bedee5fe9cb608e3fdbfe83ec92f"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/glibc
  core/gmp
  core/libffi
  core/openssl
  core/postgresql
  core/zlib
)

pkg_build_deps=(
  alasconnect/ghc82
  alasconnect/cabal-install
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
  cabal install --only-dependencies

  # Configure and Build
  cabal configure --prefix="$pkg_prefix"
  cabal build
}

do_install() {
  cabal copy
}
