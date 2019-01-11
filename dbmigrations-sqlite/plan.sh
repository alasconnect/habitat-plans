pkg_name=dbmigrations-sqlite
pkg_origin=alasconnect
pkg_version=2.0.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://github.com/jtdaugherty/dbmigrations"
pkg_description="The dbmigrations tool built for SQLite databases"
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="0ca8140ac27919890c93f45c20bdd25b4c190eec60a330069d89cb8b9a481320"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/glibc
  core/gmp
  core/libffi
  core/sqlite
)

pkg_build_deps=(
  core/ghc
  core/cabal-install
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
    --extra-lib-dirs=$(pkg_path_for sqlite)/lib --extra-include-dirs=$(pkg_path_for sqlite)/include

  # Configure and Build
  cabal configure --prefix="$pkg_prefix"
  cabal build
}

do_install() {
  cabal copy
}
