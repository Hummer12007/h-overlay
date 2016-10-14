# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3 eutils

DESCRIPTION="A hackable ncurses file manager"
HOMEPAGE="https://github.com/jollywho/nav"

EGIT_REPO_URI="https://github.com/jollywho/nav.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sys-libs/ncurses:0=[unicode]
	dev-libs/libpcre
	dev-libs/libtermkey
	dev-libs/libuv"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e 's/CURSES_LIBRARY/CURSES_LIBRARIES/' CMakeLists.txt

	default
}

pkg_postinst() {
	optfeature "image preview support" virtual/w3m
}
