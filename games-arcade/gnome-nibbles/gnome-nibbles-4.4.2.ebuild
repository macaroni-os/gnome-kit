# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Nibbles clone for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-nibbles"
SRC_URI="https://download.gnome.org/sources/gnome-nibbles/4.4/gnome-nibbles-4.4.2.tar.xz -> gnome-nibbles-4.4.2.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	media-libs/gsound[vala]
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libgee:=
	media-libs/gsound
	x11-libs/gtk:4
	x11-libs/libadwaita
	x11-libs/pango
	dev-libs/libgnome-games-support:2=
	
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
