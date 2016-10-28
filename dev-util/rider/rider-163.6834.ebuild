# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="0"

KEYWORDS="~amd64"
SRC_URI="https://download.jetbrains.com/resharper/${PN}RS-${PV}.tar.gz"
RESTRICT="mirror fetch strip splitdebug"

DESCRIPTION="A C# IDE by JetBrains"
HOMEPAGE="https://www.jetbrains.com/rider"

LICENSE="IDEA
	|| ( IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal )" # FIXME
IUSE="-custom-jdk"

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7:*"
S="${WORKDIR}/${PN}RS-${PV}"

QA_PREBUILT="opt/${P}/*"

src_prepare() {
	if ! use custom-jdk; then
		if [[ -d jre ]]; then
			rm -r jre || die
		fi
	fi
	rm -r plugins/tfsIntegration/lib/native/{aix,win32} || die
}

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{{rider,inspect}.sh,fsnotifier{,64}} "${dir}"/lib/ReSharperHost/{{dupfinder,inspectcode,JetBrains.ReSharper.Host,runtime}.sh,linux-x64/mono/bin/mono-sgen}

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "bin/Rider_128.png" "${PN}.png"
	make_desktop_entry "${PN}" "Rider" "${PN}" "Development;IDE;"
}
