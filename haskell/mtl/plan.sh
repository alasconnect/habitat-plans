hkg_name=mtl
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=2.2.1
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=http://github.com/ekmett/mtl
pkg_description="Monad classes using functional dependencies, with instances for various monad transformers, inspired by the paper Functional Programming with Overloading and Higher-Order Polymorphism, by Mark P Jones, in Advanced School of Functional Programming, 1995"
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=cae59d79f3a16f8e9f3c9adc1010c7c6cdddc73e8a97ff4305f6439d855c8dc5
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
)

pkg_build_deps=(
  core/sed
)

do_prepare() {
  sed -i 's/transformers == 0.4.\*/transformers >= 0.4/' ${hkg_name}.cabal
}

do_build() {
  runhaskell Setup configure --prefix=${pkg_prefix} -O \
    --enable-library-profiling \
    --enable-shared

  runhaskell Setup build
  runhaskell Setup register --gen-script
  sed -i -r -e "s|ghc-pkg.*update[^ ]* |&'--force' |" register.sh
}

do_install() {
  runhaskell Setup install
  install register.sh ${pkg_prefix}
}
