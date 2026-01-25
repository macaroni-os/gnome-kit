# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson gnome3 vala

DESCRIPTION="Graphical tool for editing the dconf configuration database"
HOMEPAGE="https://gitlab.gnome.org/GNOME/dconf-editor"
SRC_URI="https://download.gnome.org/sources/dconf-editor/49/dconf-editor-49.0.tar.xz -> dconf-editor-49.0.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
BDEPEND="$(vala_depend)
	dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="gnome-base/dconf
	dev-libs/glib:2
	x11-libs/gtk+:3
	dev-libs/libhandy[vala]
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
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
