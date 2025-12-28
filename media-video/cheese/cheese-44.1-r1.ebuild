# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 vala meson

DESCRIPTION="A cheesy program to take pictures and videos from your webcam"
HOMEPAGE="https://wiki.gnome.org/Apps/Cheese"
SRC_URI="https://download.gnome.org/sources/cheese/44/cheese-44.1.tar.xz -> cheese-44.1.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
# Commons depends
CDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	gnome-base/gnome-desktop
	media-libs/libcanberra[gtk3]
	media-libs/clutter[introspection?]
	media-libs/clutter-gtk
	media-libs/clutter-gst
	media-libs/cogl:=[introspection?]
	media-video/gnome-video-effects
	x11-libs/gdk-pixbuf:2[jpeg,introspection?]
	x11-libs/libX11
	x11-libs/libXtst
	media-libs/gstreamer:1.0[introspection?]
	media-libs/gst-plugins-base:1.0[introspection?,ogg,pango,theora,vorbis,X]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
BDEPEND="$(vala_depend)
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-good:1.0
	
"
DEPEND="${CDEPEND}
	app-text/docbook-xml-dtd:4.3
	app-text/yelp-tools
	dev-libs/appstream-glib
	dev-libs/libxml2
	dev-libs/libxslt
	dev-util/gdbus-codegen
	dev-util/gtk-doc-am
	dev-util/itstool
	x11-base/xorg-proto
	
"
src_prepare() {
	vala_src_prepare
	gnome3_src_prepare
}
src_configure() {
	# work around sandbox violation
	for card in /dev/dri/card* ; do
	  addpredict "${card}"
	done
	for render in /dev/dri/render* ; do
	  addpredict "${render}"
	done
	for video in /dev/video* ; do
	  addpredict "${video}"
	done
	local emesonargs=(
	  $(meson_use introspection)
	  -Dtests=false
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
