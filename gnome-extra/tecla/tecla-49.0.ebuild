# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic meson gnome3

DESCRIPTION="Tecla is a keyboard layout viewer"
HOMEPAGE="https://gitlab.gnome.org/GNOME/tecla"
SRC_URI="https://download.gnome.org/sources/tecla/49/tecla-49.0.tar.xz -> tecla-49.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="wayland"
BDEPEND="dev-libs/glib
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="x11-libs/gtk:4[introspection,wayland?]
	x11-libs/libadwaita
	x11-libs/libxkbcommon
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	use wayland || append-cppflags -DGENTOO_GTK_HIDE_WAYLAND
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
