hkg_name=tf-random
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=0.5
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=http://hub.darcs.net/michal.palka/tf-random
pkg_description="This package contains an implementation of a high-quality splittable pseudorandom number generator. The generator is based on a cryptographic hash function built on top of the ThreeFish block cipher. See the paper Splittable Pseudorandom Number Generators Using Cryptographic Hashing by Claessen, Pałka for details and the rationale of the design."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=2e30cec027b313c9e1794d326635d8fc5f79b6bf6e7580ab4b00186dadc88510
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
  alasconnect/haskell-random
  alasconnect/haskell-primitive
)

do_build() {
  runhaskell Setup configure --prefix=${pkg_prefix} -O \
    --enable-library-profiling \
    --enable-shared

  runhaskell Setup build
}

do_install() {
  runhaskell Setup install
}
