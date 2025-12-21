# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit meson vala

DESCRIPTION="GTK support library for colord"
HOMEPAGE="https://www.freedesktop.org/software/colord/"
SRC_URI="https://www.freedesktop.org/software/colord/releases/colord-gtk-0.3.1.tar.xz -> colord-gtk-0.3.1.tar.xz"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="doc +introspection vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
	  app-text/docbook-xml-dtd:4.1.2
	  dev-util/gtk-doc
	)
	app-text/docbook-xsl-ns-stylesheets
	introspection? ( dev-libs/gobject-introspection:= )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-misc/colord:=[introspection?,vala?]
	x11-libs/gtk+:3[introspection?]
	x11-libs/gtk:4[introspection?]
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	use vala && vala_src_prepare
	default
}
src_configure() {
	local -a emesonargs=(
	  -Dgtk4=true
	  -Dgtk3=true
	  -Dgtk2=false
	  -Dtests=false
	  -Dman=true
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use doc docs)
	)
	meson_src_configure
}


# vim: filetype=ebuild
