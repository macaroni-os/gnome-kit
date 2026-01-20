# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Logic puzzle game for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/hitori"
SRC_URI="https://download.gnome.org/sources/hitori/44/hitori-44.0.tar.xz -> hitori-44.0.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="app-text/yelp-tools
	dev-libs/appstream-glib
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/cairo
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	sed  -i -e "s|('desktop-file',|(|g" -e "s|('appdata-file',|(|g" data/meson.build
	gnome3_src_prepare
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
