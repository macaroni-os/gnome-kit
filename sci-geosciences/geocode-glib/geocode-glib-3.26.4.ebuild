# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg

DESCRIPTION="GLib helper library for geocoding services"
HOMEPAGE="https://gitlab.gnome.org/GNOME/geocode-glib"
SRC_URI="https://download.gnome.org/sources/geocode-glib/3.26/geocode-glib-3.26.4.tar.xz -> geocode-glib-3.26.4.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/json-glib[introspection?]
	net-libs/libsoup:3[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Denable-installed-tests=false
	  $(meson_use introspection enable-introspection)
	  $(meson_use gtk-doc enable-gtk-doc)
	  -Dsoup2=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
