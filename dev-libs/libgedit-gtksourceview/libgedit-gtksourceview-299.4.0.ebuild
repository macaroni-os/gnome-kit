# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION=""
HOMEPAGE="https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview"
SRC_URI="https://download.gnome.org/sources/libgedit-gtksourceview/299/libgedit-gtksourceview-299.4.0.tar.xz -> libgedit-gtksourceview-299.4.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/libxml2
	dev-libs/gobject-introspection:=
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dgobject_introspection=true
	  -Dtests=false
	  $(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}


# vim: filetype=ebuild
