# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 cmake-utils linux-info readme.gentoo-r1

DESCRIPTION="Toolset to accelerate the boot process and application startup"
HOMEPAGE="http://e4rat.sourceforge.net/"
EGIT_REPO_URI="https://github.com/ShyPixie/e4rat-lite.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-lang/perl:=
	>=dev-libs/boost-1.42:=
	sys-fs/e2fsprogs
	sys-process/audit[static-libs(+)]
	sys-process/lsof
"
DEPEND="${DEPEND}"

CONFIG_CHECK="~AUDITSYSCALL"

PATCHES=(
	"${FILESDIR}"/${PN}-0.2.4-sysmacros.patch #580534
	"${FILESDIR}"/${PN}-0.2.4-gcc6.patch #594046
)

pkg_setup() {
	check_extra_config
	DOC_CONTENTS="
		To launch systemd from e4rat you simply need to edit /etc/e4rat.conf
		and set:\n
		; path to init process binary (DEFAULT: /sbin/init)\n
		init /usr/lib/systemd/systemd"
}

src_prepare() {
	cmake-utils_src_prepare
	sed -i 's%/usr/lib/systemd/systemd%/sbin/init%' e4rat-lite.conf ||
		die "Failed to sed makefile"
}
src_install() {
	cmake-utils_src_install
	# relocate binaries to /sbin. If someone knows of a better way to do it
	# please do tell me
	dodir sbin
	find "${D}"/usr/bin -type f -exec mv {} "${D}"/sbin/. \; \
		|| die

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	if has_version sys-apps/preload; then
		elog "It appears you have sys-apps/preload installed. This may"
		elog "has negative effects on ${PN}. You may want to disable preload"
		elog "when using ${PN}."
	fi
}