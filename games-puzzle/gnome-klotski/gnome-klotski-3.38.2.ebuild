# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Slide blocks to solve the puzzle"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-klotski"
SRC_URI="https://download.gnome.org/sources/gnome-klotski/3.38/gnome-klotski-3.38.2.tar.xz -> gnome-klotski-3.38.2.tar.xz"
LICENSE="GPL-3+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="$(vala_depend)
	dev-libs/appstream
	dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libgee:=
	dev-libs/glib:2
	x11-libs/gtk+:3
	dev-libs/libgnome-games-support:1=
	gnome-base/librsvg
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
