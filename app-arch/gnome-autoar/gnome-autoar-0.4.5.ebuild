# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala

DESCRIPTION="Automatic archives creating and extracting library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-autoar"
SRC_URI="https://download.gnome.org/sources/gnome-autoar/0.4/gnome-autoar-0.4.5.tar.xz -> gnome-autoar-0.4.5.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk gtk-doc +introspection vala"
REQUIRED_USE="vala? ( introspection )
gtk-doc? ( gtk )
"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	vala? ( $(vala_depend) )
	
"
RDEPEND="app-arch/libarchive:=
	dev-libs/glib:2
	gtk? ( x11-libs/gtk+:3[introspection?] )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	use vala && vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk)
	  $(meson_feature introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
