# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg-utils

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"
SRC_URI="https://download.gnome.org/sources/json-glib/1.10/json-glib-1.10.8.tar.xz -> json-glib-1.10.8.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection"
BDEPEND="app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	gtk-doc? ( dev-util/gi-docgen )
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	xdg_environment_reset
	default
}
src_configure() {
	local emesonargs=(
	  # Never use gi-docgen subproject
	  --wrap-mode nofallback
	  -Dinstalled_tests=false
	  -Dman=true
	  -Dtests=false
	  $(meson_feature introspection)
	  $(meson_feature gtk-doc documentation)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	einstalldocs
	if use gtk-doc ; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html || die
	  mv "${ED}"/usr/share/doc/json-glib-1.0 "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}


# vim: filetype=ebuild
