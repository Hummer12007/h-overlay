# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A VK internet messenger client"
HOMEPAGE="https://github.com/vk-cli/vk"
EGIT_REPO_URI="https://github.com/vk-cli/vk.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	|| ( dev-lang/dmd:= dev-lang/ldc2:= )
	sys-libs/ncurses:0=[unicode]
"
DEPEND="
	dev-util/dub
	dev-util/dlang-tools[rdmd]
	${DEPEND}
"

src_compile() {
	dub build
}

src_install() {
	dobin vk
}
