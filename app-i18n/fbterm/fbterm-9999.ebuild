# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
inherit autotools-utils git-r3

DESCRIPTION="An updated fbterm fork with customizable color palette"
HOMEPAGE="https://fbterm.googlecode.com/"
EGIT_REPO_URI="https://github.com/izmntuk/fbterm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="caps gpm video_cards_vesa"

RDEPEND="caps? ( sys-libs/libcap )
	gpm? ( sys-libs/gpm )
	video_cards_vesa? ( dev-libs/libx86 )
	media-libs/fontconfig
	media-libs/freetype:2"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	virtual/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS NEWS )

src_prepare() {
	AM_OPTS="--foreign" eautoreconf
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable gpm)
		$(use_enable video_cards_vesa vesa)
	)
	autotools-utils_src_configure
}

src_compile() {
	ls
}

src_install() {
	autotools-utils_src_install
	$(type -P tic) -o "${ED}/usr/share/terminfo/" \
		"${S}"/terminfo/fbterm || die "Failed to generate terminfo database"
	if use caps; then
		setcap "cap_sys_tty_config+ep" "${ED}"/usr/bin/fbterm
	else
		fperms u+s /usr/bin/fbterm
	fi
}

pkg_postinst() {
	einfo
	einfo " ${PN} won't work with vga16fb. You have to use other native"
	einfo " framebuffer drivers or vesa driver."
	einfo " See ${EPREFIX}/usr/share/doc/${P}/README for details."
	einfo " To use ${PN}, ensure you are in video group."
	einfo " To input CJK merge app-i18n/fbterm-ucimf"
	einfo
}
