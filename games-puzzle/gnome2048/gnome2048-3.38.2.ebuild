# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Move the tiles until you obtain the 2048 tile"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-2048"
SRC_URI="https://download.gnome.org/sources/gnome-2048/3.38/gnome-2048-3.38.2.tar.xz -> gnome-2048-3.38.2.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3
	media-libs/clutter
	media-libs/clutter-gst
	dev-libs/libgee
	dev-libs/libgnome-games-support:1=
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/gnome-2048-3.38.2"
src_prepare() {
	sed -i -e "/'desktop-file',/d" -e "/'appdata-file',/d" data/meson.build
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
