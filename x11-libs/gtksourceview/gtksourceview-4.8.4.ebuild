# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson vala

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="https://wiki.gnome.org/Projects/GtkSourceView"
SRC_URI="https://download.gnome.org/sources/gtksourceview/4.8/gtksourceview-4.8.4.tar.xz -> gtksourceview-4.8.4.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="4"
KEYWORDS="*"
IUSE="glade gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	dev-libs/libxml2:=
	glade? ( dev-util/glade )
	introspection? ( dev-libs/gobject-introspection:= )
	dev-libs/fribidi
	
"
DEPEND="${RDEPEND}
	
"
src_prepare() {
	use vala && vala_src_prepare
	xdg_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dinstall_tests=false
	  $(meson_use glade glade_catalog)
	  $(meson_use introspection gir)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# Avoid conflict with gtksourceview:3.0 glade-catalog
	if use glade; then
	  mv "${ED}"/usr/share/glade/catalogs/gtksourceview.xml "${ED}"/usr/share/glade/catalogs/gtksourceview-${SLOT}.xml || die
	fi
}


# vim: filetype=ebuild
