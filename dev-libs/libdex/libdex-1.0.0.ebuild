# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala

DESCRIPTION="Dex provides Future-based programming for GLib-based applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libdex"
SRC_URI="https://download.gnome.org/sources/libdex/1.0/libdex-1.0.0.tar.xz -> libdex-1.0.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+eventfd gtk-doc +introspection +liburing sysprof vala"
REQUIRED_USE="gtk-doc? ( introspection )
vala? ( introspection )
"
BDEPEND="vala? ( $(vala_depend) )
	virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	
"
RDEPEND="dev-libs/glib:2
	liburing?  ( sys-libs/liburing:= )
	introspection? ( dev-libs/gobject-introspection:= )
	sysprof? ( dev-util/sysprof )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dexamples=false
	  -Dtests=false
	  $(meson_use gtk-doc docs)
	  $(meson_use vala vapi)
	  $(meson_feature introspection)
	  $(meson_use sysprof)
	  $(meson_feature liburing)
	  $(meson_feature eventfd)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/${PN}-1 "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}


# vim: filetype=ebuild
