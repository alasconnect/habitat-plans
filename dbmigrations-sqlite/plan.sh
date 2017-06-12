pkg_name=dbmigrations-sqlite
pkg_origin=alasconnect
pkg_version=2.0.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://github.com/jtdaugherty/dbmigrations
pkg_description="The dbmigrations tool built for SQLite databases"
pkg_source=https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=0ca8140ac27919890c93f45c20bdd25b4c190eec60a330069d89cb8b9a481320

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/libiconv
  core/glibc
  core/sqlite
)

pkg_build_deps=(
  alasconnect/ghc
  alasconnect/cabal-install
  core/gcc-libs
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  export LD_LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for core/gcc-libs)/lib"

  cabal sandbox init
  cabal update

  cabal install --only-dependencies \
    --extra-lib-dirs=$(pkg_path_for sqlite)/lib --extra-include-dirs=$(pkg_path_for sqlite)/include
  cabal build
}

do_install() {
  cabal install --prefix="$pkg_prefix"
}
