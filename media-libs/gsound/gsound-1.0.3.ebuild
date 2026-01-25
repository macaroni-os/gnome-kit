# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala

DESCRIPTION="Thin GObject wrapper around the libcanberra sound event library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gsound"
SRC_URI="https://download.gnome.org/sources/gsound/1.0/gsound-1.0.3.tar.xz -> gsound-1.0.3.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	media-libs/libcanberra
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
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  $(meson_use vala enable_vala)
	)
	meson_src_configure
}


# vim: filetype=ebuild
