pkg_name=greenplum-db
pkg_origin=alasconnect
pkg_version=5.0.0-alpha.8
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('Apache-2.0')
pkg_upstream_url=http://greenplum.org/
pkg_description="Greenplum Database® is an advanced, fully featured, open source data warehouse."
pkg_source=https://github.com/greenplum-db/gpdb/archive/${pkg_version}.tar.gz
pkg_shasum=5c505815b9ad28bdfe98aa73c487d924d0168fb8b7e4e1343b1f25fc099f1035
pkg_dirname=gpdb-${pkg_version}

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/curl
  core/openssl
  core/zlib
  core/python2
  core/perl
  core/libxml2
  core/libffi
  alasconnect/gporca
  alasconnect/gp-xerces
  core/readline
  core/apr
  core/libevent
  core/bzip2
  core/coreutils
)

pkg_build_deps=(
  core/gcc
  core/make
  core/cacerts
  core/bison2
  core/flex
)

do_build() {
  tee requirements.txt <<EOF
psutil
lockfile>=0.9.1
paramiko
setuptools
EOF

  export SSL_CERT_FILE="$(pkg_path_for cacerts)/ssl/cert.pem"
  pip install --upgrade pip
  pip install --install-option="--prefix=${pkg_prefix}" -r requirements.txt

  # ld manpage: "If -rpath is not used when linking an ELF
  # executable, the contents of the environment variable LD_RUN_PATH
  # will be used if it is defined"
  ./configure --prefix="${pkg_prefix}" \
    --disable-rpath \
    --with-perl \
    --with-python \
    --with-libxml \
    --with-openssl \
    --sysconfdir="$pkg_svc_config_path" \
    --localstatedir="$pkg_svc_var_path"


  fix_interpreter "src/backend/catalog/*" core/perl bin/perl
  fix_interpreter "src/test/regress/*" core/coreutils bin/env

  make
}

do_install() {
  attach
}