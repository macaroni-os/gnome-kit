# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Complete the puzzle by matching numbered tiles"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-tetravex"
SRC_URI="https://download.gnome.org/sources/gnome-tetravex/3.38/gnome-tetravex-3.38.3.tar.xz -> gnome-tetravex-3.38.3.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="cli +gui"
BDEPEND="${PYTHON_DEPS}
	$(vala_depend)
	gui? ( dev-util/itstool )
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	gui? ( x11-libs/gtk+:3 )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  $(meson_use cli build_cli)
	  $(meson_use gui build_gui)
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
