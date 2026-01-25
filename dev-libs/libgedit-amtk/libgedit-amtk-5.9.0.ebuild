# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Actions, Menus and Toolbars Kit for GTK applications"
HOMEPAGE="https://gitlab.gnome.org/World/gedit/libgedit-amtk"
SRC_URI="https://download.gnome.org/sources/libgedit-amtk/5.9/libgedit-amtk-5.9.0.tar.xz -> libgedit-amtk-5.9.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection gtk-doc"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="!x11-libs/amtk
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_use introspection gobject_introspection)
	  $(meson_use gtk-doc gtk_doc)
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
