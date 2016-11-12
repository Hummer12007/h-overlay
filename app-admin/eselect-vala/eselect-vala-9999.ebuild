# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Eselect module to maintain vala compiler symlink"
HOMEPAGE="http://code.google.com/p/eselect-vala/"
EGIT_REPO_URI="http://code.google.com/p/eselect-vala/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/eselect
	dev-lang/val
"

DEPEND="${RDEPEND}
	sys-devel/m4
"

DOCS="AUTHORS README"

src_install() {
	emake DESTDIR="${D}" install
	dodoc ${DOCS}
}
