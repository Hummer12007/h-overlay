# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 eutils cmake-utils

DESCRIPTION="Modular Wayland compositor"
HOMEPAGE="https://github.com/Cloudef/orbment"

EGIT_REPO_URI="https://github.com/Cloudef/orbment.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

RDEPEND="=dev-libs/wlc-9999[systemd=]
	dev-libs/json-c
	dev-libs/libpcre
	dev-libs/libinput
	x11-libs/libxkbcommon
	dev-libs/wayland
	sys-libs/libcap
	x11-libs/pango
	x11-libs/cairo"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use !systemd && fperms u+s /usr/bin/orbment
}

