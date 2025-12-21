# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson gnome3 vala

DESCRIPTION="GLib-based library for accessing online service APIs using the GData protocol"
HOMEPAGE="https://wiki.gnome.org/Projects/libgdata"
SRC_URI="https://download.gnome.org/sources/libgdata/0.18/libgdata-0.18.1.tar.xz -> libgdata-0.18.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+crypt gnome-online-accounts gtk-doc +introspection vala"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/json-glib[introspection?]
	dev-libs/libxml2:2=
	net-libs/libsoup:2.4[introspection?,vala?]
	crypt? ( app-crypt/gcr:= )
	gnome-online-accounts? ( net-libs/gnome-online-accounts[introspection?,vala?] )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
	gnome3_environment_reset
	# Don't waste time building a couple small demos that aren't installed
	sed -i -e '/subdir.*demos/d' meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Dgtk=disabled # only for demos
	  -Doauth1=disabled
	  -Dalways_build_tests=false
	  -Dinstalled_tests=false
	  -Dman=true
	  $(meson_feature crypt gnome)
	  $(meson_feature gnome-online-accounts goa)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
