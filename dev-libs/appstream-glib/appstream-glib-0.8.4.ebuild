# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 gnome3 meson

DESCRIPTION="This library provides objects and helper methods to help reading and writing AppStream metadata."
HOMEPAGE="https://github.com/hughsie/appstream-glib"
SRC_URI="https://api.github.com/repos/hughsie/appstream-glib/tarball/refs/tags/appstream_glib_0_8_4 -> appstream-glib-0.8.4-5bce4d6.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc fonts +introspection"
BDEPEND="dev-util/gperf
	gtk-doc? (
	  dev-util/gdk-doc
	  dev-util/gtk-doc-am
	)
	sys-devel/gettext
	
"
RDEPEND="dev-libs/glib:2
	sys-apps/util-linux
	app-arch/libarchive:=
	net-misc/curl
	dev-libs/json-glib
	x11-libs/gdk-pixbuf:2[introspection?]
	fonts? (
	  x11-libs/gtk+:3
	  media-libs/freetype:2
	)
	media-libs/fontconfig
	dev-libs/libyaml
	x11-libs/pango
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.3
	dev-libs/libxslt
	
"

post_src_unpack() {
	mv hughsie-appstream-glib-* ${S}
}


src_configure() {
	local emesonargs=(
	  -Ddep11=true
	  -Dbuilder=true
	  -Drpm=false
	  -Dalpm=false
	  -Dman=true
	  $(meson_use fonts)
	  $(meson_use gtk-doc)
	  $(meson_use introspection)
	)
	meson_src_configure
}



# vim: filetype=ebuild
