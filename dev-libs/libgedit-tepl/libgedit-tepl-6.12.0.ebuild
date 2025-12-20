# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="GtkSourceView-based text editors and IDE helper library"
HOMEPAGE="https://gitlab.gnome.org/World/gedit/libgedit-tepl"
SRC_URI="https://download.gnome.org/sources/libgedit-tepl/6.12/libgedit-tepl-6.12.0.tar.xz -> libgedit-tepl-6.12.0.tar.xz"
LICENSE="LGPL-3+"
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
RDEPEND="!gui-libs/tepl
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/libgedit-gtksourceview
	dev-libs/libgedit-amtk:=[introspection]
	dev-libs/libgedit-gfls
	dev-libs/icu:=
	gnome-base/gsettings-desktop-schemas
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
