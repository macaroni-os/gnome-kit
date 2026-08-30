# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake gnome3

DESCRIPTION="Evolution module for connecting to Microsoft Exchange Web Services"
HOMEPAGE="https://gitlab.gnome.org/GNOME/evolution-ews"
SRC_URI="https://download.gnome.org/sources/evolution-ews/3.58/evolution-ews-3.58.3.tar.xz -> evolution-ews-3.58.3.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/gdbus-codegen
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libical:=
	dev-libs/json-glib
	dev-libs/libmspack
	dev-libs/libxml2:2=
	gnome-extra/evolution-data-server:=
	mail-client/evolution
	net-libs/libsoup:3
	x11-libs/gtk+:3
	
"
DEPEND="${RDEPEND}
	
"
src_prepare() {
	cmake_src_prepare
	gnome3_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DWITH_MSPACK=ON
	  -DENABLE_TESTS=OFF
	)
	cmake_src_configure
}
src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
}


# vim: filetype=ebuild
