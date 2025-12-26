# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="A quick previewer for Nautilus, the GNOME file manager"
HOMEPAGE="https://gitlab.gnome.org/GNOME/sushi"
SRC_URI="https://download.gnome.org/sources/sushi/46/sushi-46.0.tar.xz -> sushi-46.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="wayland +X +papers"
REQUIRED_USE="|| ( wayland X )"
# Commons depends
CDEPEND="media-libs/libepoxy
	papers? (
	  app-text/papers
	)
	!papers? (
	  app-text/evince[introspection]
	)
	media-libs/freetype
	x11-libs/gdk-pixbuf[introspection]
	dev-libs/glib:2
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	x11-libs/gtk+:3[introspection,wayland?,X?]
	x11-libs/gtksourceview:4[introspection]
	media-libs/harfbuzz:=
	dev-libs/gobject-introspection:=
	dev-libs/gjs
	
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	gnome-base/nautilus
	
"
DEPEND="${CDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_feature wayland)
	  $(meson_feature X X11)
	  -Dprofile=default
	)
	meson_src_configure
}
src_compile() {
	local -x GST_PLUGIN_SYSTEM_PATH_1_0=
	meson_src_compile
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
