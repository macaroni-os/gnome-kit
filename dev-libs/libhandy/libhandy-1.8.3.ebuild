# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala xdg

DESCRIPTION="Building blocks for modern adaptive GNOME apps"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libhandy"
SRC_URI="https://download.gnome.org/sources/libhandy/1.8/libhandy-1.8.3.tar.xz -> libhandy-1.8.3.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="examples glade gtk-doc +introspection +vala"
BDEPEND="dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? (
	  dev-util/gi-docgen
	  app-text/docbook-xml-dtd:4.3
	)
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	glade? ( dev-util/glade:= )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dprofiling=false # -pg passing
	  -Dtests=false
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use examples)
	  $(meson_feature introspection)
	  $(meson_feature glade glade_catalog)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
