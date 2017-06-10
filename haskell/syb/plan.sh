hkg_name=syb
pkg_name=haskell-${hkg_name}
pkg_origin=alasconnect
pkg_version=0.7
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=	http://www.cs.uu.nl/wiki/GenericProgramming/SYB
pkg_description="This package contains the generics system described in the Scrap Your Boilerplate papers (see http://www.cs.uu.nl/wiki/GenericProgramming/SYB). It defines the Data class of types permitting folding and unfolding of constructor applications, instances of this class for primitive types, and a variety of traversals."
pkg_source=https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz
pkg_shasum=b8757dce5ab4045c49a0ae90407d575b87ee5523a7dd5dfa5c9d54fcceff42b5
pkg_dirname=${hkg_name}-${pkg_version}

pkg_lib_dirs=(lib)

pkg_deps=(
  alasconnect/ghc
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
