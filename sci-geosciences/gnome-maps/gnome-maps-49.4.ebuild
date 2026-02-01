# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="A map application for GNOME"
HOMEPAGE="https://apps.gnome.org/Maps/"
SRC_URI="https://download.gnome.org/sources/gnome-maps/49/gnome-maps-49.4.tar.xz -> gnome-maps-49.4.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	sys-devel/gettext
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/gjs
	dev-libs/gobject-introspection:=
	x11-libs/gtk:4[introspection]
	app-misc/geoclue[introspection]
	x11-libs/libadwaita[introspection]
	dev-libs/libgweather:=[introspection]
	sci-geosciences/geocode-glib[introspection]
	dev-libs/libportal:=[introspection]
	media-libs/libshumate:=[introspection]
	dev-libs/libxml2
	net-libs/rest[introspection]
	gnome-base/librsvg
	dev-libs/json-glib
	app-crypt/libsecret[introspection]
	media-libs/graphene[introspection]
	net-libs/libsoup:3[introspection]
	x11-libs/pango[introspection]
	
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
