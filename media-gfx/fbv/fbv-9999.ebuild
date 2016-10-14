# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="framebuffer image viewer"
HOMEPAGE="https://github.com/godspeed1989/fbv"
EGIT_REPO_URI="https://github.com/godspeed1989/fbv"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+jpeg +png"

DEPEND="
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
"
RDEPEND="${DEPEND}"

src_configure() {
	local confargs=()

	use png || confargs += "--without-libpng"
	use jpeg || confargs += "--without-libjpeg"

	./configure \
		--prefix="/usr" \
		--mandir="/usr/share/man" \
		${confargs}|| die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

DOCS=( README.md )
src_install() {
	dobin fbv
	doman fbv.1
	einstalldocs
}
