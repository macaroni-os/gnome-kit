# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Remove colored balls from the board by forming lines"
HOMEPAGE="https://gitlab.gnome.org/GNOME/five-or-more"
SRC_URI="https://download.gnome.org/sources/five-or-more/48/five-or-more-48.1.tar.xz -> five-or-more-48.1.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
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
