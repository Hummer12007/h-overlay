# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3

DESCRIPTION="A utility to manage ebuilds in overlays"
HOMEPAGE="https://wiki.gentoo.org/User:Hummer12007/pomu"

EGIT_REPO_URI="https://git.sr.ht/~hummer12007/pomu"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	app-portage/repoman[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/curtsies[${PYTHON_USEDEP}]
	dev-python/git-python[${PYTHON_USEDEP}]
	dev-python/patch[${PYTHON_USEDEP}]
	dev-python/pbraw[${PYTHON_USEDEP}]
	sys-apps/portage[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install

	doman doc/pomu.1
}
