# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Clear hidden mines from a minefield"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-mines"
SRC_URI="https://download.gnome.org/sources/gnome-mines/49/gnome-mines-49.0.1.tar.xz -> gnome-mines-49.0.1.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
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
	x11-libs/libadwaita[vala]
	gnome-base/librsvg[vala]
	dev-libs/libgnome-games-support:2=
	
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
