# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Play the classic two-player boardgame of chess"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-chess"
SRC_URI="https://download.gnome.org/sources/gnome-chess/49/gnome-chess-49.2.tar.xz -> gnome-chess-49.2.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
BDEPEND="$(vala_depend)
	dev-util/itstool
	dev-libs/appstream-glib
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	x11-libs/pango
	gnome-base/librsvg[vala]
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	gnome3_src_prepare
	vala_src_prepare
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
