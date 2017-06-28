# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3 python-r1

DESCRIPTION="A utility to manage ebuilds in overlays"
HOMEPAGE="https://wiki.gentoo.org/User:Hummer12007/pomu"

EGIT_REPO_URI="https://git.sr.ht/~hummer12007/pomu"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	app-portage/repoman
	dev-python/click
	dev-python/git-python
	sys-apps/portage
"

RESTRICT="test" # verify that tests work
