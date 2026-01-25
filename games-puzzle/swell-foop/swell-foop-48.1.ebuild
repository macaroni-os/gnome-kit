# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Clear the screen by removing groups of colored and shaped tiles"
HOMEPAGE="https://gitlab.gnome.org/GNOME/swell-foop"
SRC_URI="https://download.gnome.org/sources/swell-foop/48/swell-foop-48.1.tar.xz -> swell-foop-48.1.tar.xz"
LICENSE="GPL-2+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	dev-libs/libgnome-games-support:2=
	gnome-base/librsvg[vala]
	dev-libs/libgee:=
	
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
