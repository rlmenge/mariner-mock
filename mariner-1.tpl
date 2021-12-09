config_opts['chroot_setup_cmd'] = 'install tar which xz sed make bzip2 gzip gcc coreutils unzip shadow-utils diffutils cpio bash gawk rpm-build patch findutils grep vim filesystem kernel-headers glibc glibc-devel glibc-i18n glibc-iconv glibc-lang glibc-nscd glibc-tools zlib zlib-devel file file-devel file-libs binutils binutils-devel gmp gmp-devel mpfr mpfr-devel libmpc libgcc libgcc-atomic libgcc-devel libstdc++ libstdc++-devel libgomp libgomp-devel pkg-config ncurses ncurses-compat ncurses-devel ncurses-libs ncurses-term readline readline-devel coreutils-lang bash-devel bash-lang bzip2-devel bzip2-libs sed-lang procps-ng procps-ng-devel procps-ng-lang m4 grep-lang findutils-lang gettext mariner-release util-linux util-linux-devel util-linux-libs xz-devel xz-lang xz-libs zstd zstd-devel zstd-libs libtool flex flex-devel bison popt popt-devel popt-lang nspr nspr-devel sqlite sqlite-devel sqlite-libs nss nss-devel nss-libs elfutils elfutils-devel elfutils-devel-static elfutils-libelf elfutils-libelf-devel elfutils-libelf-devel-static elfutils-libelf-lang expat expat-devel expat-libs libpipeline libpipeline-devel gdbm gdbm-devel gdbm-lang perl texinfo autoconf automake openssl openssl-devel openssl-libs openssl-perl openssl-static openssl-debuginfo libcap libcap-devel libcap-ng libdb libdb-devel libdb-docs rpm rpm-build-libs rpm-devel rpm-lang rpm-libs cpio-lang e2fsprogs-libs libsolv libsolv-devel libssh2 libssh2-devel curl curl-devel curl-libs tdnf tdnf-cli-libs tdnf-devel tdnf-plugin-repogpgcheck createrepo_c libxml2 libxml2-devel glib libltdl libltdl-devel pcre pcre-libs krb5 lua mariner-rpm-macros mariner-check-macros libassuan libgpg-error libgcrypt libksba npth pinentry gnupg2 gpgme mariner-repos mariner-repos-preview libffi libtasn1 p11-kit p11-kit-trust ca-certificates-shared ca-certificates-tools ca-certificates-base libselinux'
config_opts['chroot_additional_packages'] = ''
config_opts['extra_chroot_dirs'] = [ '/run/lock', '/usr/src/mariner' ]
config_opts['package_manager'] = 'dnf'
config_opts['releasever'] = '1.0'
# DNF may not be available in this chroot
config_opts['use_bootstrap'] = False

config_opts['useradd'] = '/usr/sbin/useradd -m -u {{chrootuid}} -g {{chrootgid}} -d {{chroothome}} {{chrootuser}}' 

config_opts['dnf.conf'] = """

[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/dnf.log
retries=20
obsoletes=1
gpgcheck=0
assumeyes=1
syslog_ident=mock
syslog_device=
install_weak_deps=0
metadata_expire=0
mdpolicy=group:primary
best=1
install_weak_deps=0
protected_packages=
user_agent={{ user_agent }}

[baseos]
name=CBL-Mariner Official Base $releasever $basearch
baseurl=https://packages.microsoft.com/cbl-mariner/$releasever/prod/base/$basearch/rpms
gpgcheck=0
skip_if_unavailable=True
sslverify=1

[update]
name=CBL-Mariner Official Update $releasever $basearch
baseurl=https://packages.microsoft.com/cbl-mariner/$releasever/prod/update/$basearch/rpms
gpgcheck=0
skip_if_unavailable=True
sslverify=1

"""
