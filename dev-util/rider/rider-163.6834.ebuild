# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="0"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://download.jetbrains.com/resharper/${PN}RS-${PV}.tar.gz"
RESTRICT="mirror fetch strip"

DESCRIPTION="A C# IDE by JetBrains"
HOMEPAGE="https://www.jetbrains.com/idea"

LICENSE="IDEA
	|| ( IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal )"
IUSE="-custom-jdk"

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7:*"
S="${WORKDIR}/${PN}RS-${PV}"

QA_PREBUILT="opt/${P}/*"

src_prepare() {
	if ! use amd64; then
		rm -r plugins/tfsIntegration/lib/native/linux/x86_64 || die
	fi
	if ! use arm; then
		rm bin/fsnotifier-arm || die
		rm -r plugins/tfsIntegration/lib/native/linux/arm || die
	fi
	if ! use ppc; then
		rm -r plugins/tfsIntegration/lib/native/linux/ppc || die
	fi
	if ! use x86; then
		rm -r plugins/tfsIntegration/lib/native/linux/x86 || die
	fi
	if ! use custom-jdk; then
		if [[ -d jre ]]; then
			rm -r jre || die
		fi
	fi
	rm -r plugins/tfsIntegration/lib/native/solaris || die
	rm -r plugins/tfsIntegration/lib/native/hpux || die
}

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{rider.sh,fsnotifier{,64}}

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "bin/Rider_128.png" "${PN}.png"
	make_desktop_entry "${PN}" "Rider" "${PN}" "Development;IDE;"
}
