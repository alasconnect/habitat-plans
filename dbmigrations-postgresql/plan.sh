pkg_name=dbmigrations-postgresql
pkg_origin=alasconnect
pkg_version=2.0.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/jtdaugherty/dbmigrations-postgresql
pkg_description="The dbmigrations tool built for PostgreSQL databases"
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=fcf753778e2e071c8fa452c585b93c27c973bedee5fe9cb608e3fdbfe83ec92f
pkg_bin_dirs=(bin)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
  core/gcc
)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
  core/postgresql
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for core/gcc)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
