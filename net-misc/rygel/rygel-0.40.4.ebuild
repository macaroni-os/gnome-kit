# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson systemd vala xdg

DESCRIPTION="Rygel is an open source UPnP/DLNA MediaServer"
HOMEPAGE="https://wiki.gnome.org/Projects/Rygel"
SRC_URI="https://download.gnome.org/sources/rygel/0.40/rygel-0.40.4.tar.xz -> rygel-0.40.4.tar.xz"
LICENSE="LGPL-2.1+ CC-BY-SA-3.0 GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="X +introspection +sqlite tracker test transcode gtk-doc"
BDEPEND="$(vala_depend)
	app-text/docbook-xml-dtd:4.5
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib
	dev-libs/libgee:0.8
	dev-libs/libxml2:2
	media-libs/gupnp-dlna:2.0
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/libmediaart:2.0
	media-plugins/gst-plugins-soup:1.0
	media-libs/gstreamer-editing-services:1.0
	net-libs/gssdp
	net-libs/gupnp
	net-libs/gupnp-av
	net-libs/libsoup:2.4
	sys-apps/util-linux
	x11-misc/shared-mime-info
	introspection? ( dev-libs/gobject-introspection:= )
	sqlite? (
	  dev-db/sqlite
	  dev-libs/libunistring:=
	  x11-libs/gdk-pixbuf:2
	)
	tracker? ( >=app-misc/tracker:= )
	transcode? (
	  media-libs/gst-plugins-bad:1.0
	  media-plugins/gst-plugins-twolame:1.0
	  media-plugins/gst-plugins-libav:1.0
	)
	X? ( x11-libs/gtk+:3 )
	
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	
"
src_prepare() {
	vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk-doc api-docs)
	  -Dsystemd-user-units-dir=$(systemd_get_userunitdir)
	  -Dplugins=gst-launch$(use sqlite && echo ",lms,media-export")$(use tracker && echo ",tracker3")
	  -Dengines=gstreamer
	  -Dexamples=false
	  $(meson_use test tests)
	  $(meson_feature X gtk)
	  $(meson_feature introspection)
	)
	meson_src_configure
}


# vim: filetype=ebuild
