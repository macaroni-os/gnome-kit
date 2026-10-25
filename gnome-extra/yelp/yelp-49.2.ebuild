# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION=""
HOMEPAGE="https://gitlab.gnome.org/GNOME/yelp"
SRC_URI="https://download.gnome.org/sources/yelp/49/yelp-49.2.tar.xz -> yelp-49.2.tar.xz"
LICENSE="GPL-+2+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	dev-libs/libxml2
	dev-libs/libxslt
	dev-db/sqlite:3
	net-libs/webkit-gtk:6
	>=gnome-extra/yelp-xsl-42.3
	app-arch/xz-utils:=
	app-arch/bzip2:=
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
		-Dlzma=enabled
		-Dbzip2=enabled
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
