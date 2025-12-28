# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Experimental new features for GTK+ and GLib"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libdazzle"
SRC_URI="https://download.gnome.org/sources/libdazzle/3.44/libdazzle-3.44.0.tar.xz -> libdazzle-3.44.0.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="vala? ( $(vala_depend) )
	dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Denable_tracing=false # extra trace debugging that would make things slower
	  -Denable_profiling=false # -pg passing
	  -Denable_rdtscp=false
	  -Denable_tests=false
	  -Denable_tools=true # /usr/bin/dazzle-list-counters
	  $(meson_use introspection with_introspection)
	  $(meson_use vala with_vapi)
	  $(meson_use gtk-doc enable_gtk_doc)
	)
	meson_src_configure
}


# vim: filetype=ebuild
