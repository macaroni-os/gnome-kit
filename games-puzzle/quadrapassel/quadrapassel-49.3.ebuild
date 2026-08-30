# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Fit falling blocks together"
HOMEPAGE="https://gitlab.gnome.org/GNOME/quadrapassel"
SRC_URI="https://download.gnome.org/sources/quadrapassel/49/quadrapassel-49.3.tar.xz -> quadrapassel-49.3.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/libgee
	media-libs/gsound[vala]
	x11-libs/gtk:4
	x11-libs/libadwaita
	x11-libs/pango
	dev-libs/libgnome-games-support:2=
	dev-libs/libmanette[vala]
	gnome-base/librsvg[vala]
	
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
