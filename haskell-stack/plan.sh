pkg_name=haskell-stack
pkg_origin=alasconnect
pkg_version=1.4.0
pkg_source=https://github.com/commercialhaskell/stack/releases/download/v${pkg_version}/stack-${pkg_version}-linux-x86_64-static.tar.gz
pkg_shasum=8cc2bb0da1e5f77de7257662c63c82ed289b09a37c72c2fc7a8a81983dbe30ba
pkg_bin_dirs=(bin)

ghc_version=8.0.2
pkg_deps=(
  alasconnect/ghc/${ghc_version}
  core/cacerts
  core/coreutils
  core/gawk
  core/sed
  core/perl
  core/make
  core/tar
  core/xz
  core/zlib
  core/gmp/6.1.0/20170513202112
  core/gnupg
  core/libffi
  core/gcc
  core/glibc
)

do_unpack() {
  local source_dir=$HAB_CACHE_SRC_PATH/${pkg_dirname}

  mkdir "$source_dir"

  pushd "$source_dir" >/dev/null
  tar xz --strip-components=1 -f "$HAB_CACHE_SRC_PATH/$pkg_filename"
  popd > /dev/null

  return 0
}

do_build() {
  return 0
}

do_install() {
  cp -vr ./* "$pkg_prefix"

  # generate wrapper script to provide path to root certificates
  cat > "$pkg_prefix/bin/stack" <<- EOM
#!/bin/sh

mkdir -p ~/.stack/programs/x86_64-linux
ln -sf "$(pkg_path_for ghc)" ~/.stack/programs/x86_64-linux/ghc-${ghc_version}
echo "installed" > ~/.stack/programs/x86_64-linux/ghc-${ghc_version}.installed

export SYSTEM_CERTIFICATE_PATH="$(pkg_path_for cacerts)/ssl/certs"

#fix trouble stack has finding awk
export AWK="$(pkg_path_for gawk)/bin/awk"

# fix trouble stack has finding libgmp
export LIBRARY_PATH="\$LIBRARY_PATH:${LD_RUN_PATH}"
export LD_LIBRARY_PATH="\$LD_LIBRARY_PATH:${LD_RUN_PATH}"
export LD_RUN_PATH="\$LD_RUN_PATH:${LD_RUN_PATH}"

exec $pkg_prefix/stack \$@
EOM

  chmod +x "$pkg_prefix/bin/stack"
}

do_strip() {
  # skip stripping binary as it may cause issues with patched binaries
  return 0
}
