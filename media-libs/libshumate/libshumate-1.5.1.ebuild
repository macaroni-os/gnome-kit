# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND=vapigen
inherit meson vala

DESCRIPTION="Shumate is a GTK toolkit providing widgets for embedded maps"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libshumate"
SRC_URI="https://download.gnome.org/sources/libshumate/1.5/libshumate-1.5.1.tar.xz -> libshumate-1.5.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection sysprof vala"
REQUIRED_USE="gtk-doc? ( introspection )"
BDEPEND="dev-util/gperf
	gtk-doc? ( dev-util/gi-docgen )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	dev-db/sqlite
	x11-libs/gtk:4
	net-libs/libsoup:3
	introspection? ( dev-libs/gobject-introspection:= )
	dev-libs/json-glib[introspection?]
	dev-libs/protobuf-c
	
"
DEPEND="${RDEPEND}
	sysprof? ( dev-util/sysprof )
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Ddemos=false
	  -Dvector_renderer=true
	  $(meson_use introspection gir)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_feature sysprof)
	)
	meson_src_configure
}


# vim: filetype=ebuild
