# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Test your logic skills in this number grid puzzle"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-sudoku"
SRC_URI="https://download.gnome.org/sources/gnome-sudoku/49/gnome-sudoku-49.6.tar.xz -> gnome-sudoku-49.6.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	$(vala_depend)
	dev-libs/appstream-glib
	dev-util/blueprint-compiler
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libgee:=[introspection]
	x11-libs/gtk:4[introspection]
	x11-libs/libadwaita[introspection,vala]
	dev-libs/json-glib
	dev-libs/qqwing:=
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/pango[introspection]
	
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
