# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit fdo-mime git-r3

DESCRIPTION="A small hack that uses ICU and libguess to detect character encodings and convert them to UTF-8"
HOMEPAGE="https://github.com/lachs0r/dejizz"
EGIT_REPO_URI="https://github.com/lachs0r/dejizz.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-libs/icu
	app-i18n/libguess
"

DOCS=( README.rst )

src_install() {
	dobin dejizz
}
