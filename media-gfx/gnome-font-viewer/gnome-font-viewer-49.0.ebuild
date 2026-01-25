# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Font viewer utility for GNOME"
HOMEPAGE="https://apps.gnome.org/FontViewer/"
SRC_URI="https://download.gnome.org/sources/gnome-font-viewer/49/gnome-font-viewer-49.0.tar.xz -> gnome-font-viewer-49.0.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream-glib
	dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	media-libs/harfbuzz:=
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	dev-libs/fribidi
	
"
DEPEND="${RDEPEND}
"
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
