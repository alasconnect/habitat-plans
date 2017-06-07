pkg_name=haskell-stack-bin
pkg_origin=alasconnect
pkg_version=1.4.0
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskellstack.org/
pkg_description="Stack is a cross-platform program for developing Haskell projects."
pkg_source=https://github.com/commercialhaskell/stack/releases/download/v${pkg_version}/stack-${pkg_version}-linux-x86_64-static.tar.gz
pkg_shasum=8cc2bb0da1e5f77de7257662c63c82ed289b09a37c72c2fc7a8a81983dbe30ba
pkg_dirname=stack-${pkg_version}-linux-x86_64-static
pkg_bin_dirs=(bin)

pkg_deps=(
  core/cacerts
  core/gcc
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
  core/tar
  core/ncurses
  core/gawk
)

do_build() {
  return 0
}

do_install() {
  cp -vr stack $pkg_prefix

  cat > "$pkg_prefix/bin/stack" <<- EOF
#!/bin/sh

export SYSTEM_CERTIFICATE_PATH="$(pkg_path_for cacerts)/ssl/certs"

# Help Stack access sh. Required for 'network' and 'old-time' packages for example
export PATH="\$PATH:/bin"

export AWK="$(pkg_path_for gawk)/bin/awk"

export LIBRARY_PATH="\$LIBRARY_PATH:${LD_RUN_PATH}"
export LD_LIBRARY_PATH="\$LD_LIBRARY_PATH:${LD_RUN_PATH}"
export LD_RUN_PATH="\$LD_RUN_PATH:${LD_RUN_PATH}"

exec "$pkg_prefix/stack" --system-ghc \
  --extra-include-dirs="$(pkg_path_for core/zlib)/include" \
  --extra-lib-dirs="$(pkg_path_for core/zlib)/lib" \$@
EOF

  chmod +x "$pkg_prefix/bin/stack"
}
