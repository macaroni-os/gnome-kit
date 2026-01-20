# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Unicode character map viewer and library"
HOMEPAGE="https://apps.gnome.org/Characters/"
SRC_URI="https://download.gnome.org/sources/gnome-characters/49/gnome-characters-49.1.tar.xz -> gnome-characters-49.1.tar.xz"
LICENSE="GPL-2+ BSD"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/gjs
	dev-libs/glib:2
	dev-libs/gobject-introspection:=
	x11-libs/gtk:4[introspection]
	x11-libs/libadwaita:=
	x11-libs/gdk-pixbuf:2
	x11-libs/pango[introspection]
	gnome-base/gnome-desktop
	
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
