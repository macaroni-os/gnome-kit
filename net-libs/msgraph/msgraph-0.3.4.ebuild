# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="GLib-based library for accessing online serive APIs using MS Graph protocol."
HOMEPAGE="https://gitlab.gnome.org/GNOME/msgraph"
SRC_URI="https://download.gnome.org/sources/msgraph/0.3/msgraph-0.3.4.tar.xz -> msgraph-0.3.4.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="debug gtk-doc +introspection man"
BDEPEND="gtk-doc? ( dev-util/gi-docgen )
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	net-libs/rest
	net-libs/libsoup:3
	net-libs/gnome-online-accounts:=
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/gobject-introspection-common
	
"
src_configure() {
	local emesonargs=(
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
