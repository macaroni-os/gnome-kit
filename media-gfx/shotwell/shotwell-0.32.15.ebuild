# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Shotwell"
SRC_URI="https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.15.tar.xz -> shotwell-0.32.15.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="opencv udev"
BDEPEND="$(vala_depend)
	virtual/pkgconfig
	sys-devel/gettext
	dev-util/itstool
	
"
RDEPEND="x11-libs/gtk+:3
	dev-libs/glib:2
	dev-libs/libgee
	net-libs/webkit-gtk:4
	dev-libs/json-glib
	dev-libs/libxml2
	x11-libs/gdk-pixbuf:2
	dev-db/sqlite:3
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/libgphoto2:=
	udev? ( virtual/libgudev:= )
	media-libs/gexiv2
	media-libs/libraw:=
	media-libs/libexif:=
	dev-libs/libgdata
	app-crypt/gcr:=[gtk,vala]
	x11-libs/cairo
	opencv? ( media-libs/opencv:= )
	media-libs/libchamplain[vala]
	
"
DEPEND="${RDEPEND}
	net-libs/libsoup:2.4[vala]
	dev-libs/appstream-glib
	
"
src_prepare() {
	xdg_src_prepare
	vala_src_prepare
	if use opencv ; then
	  # opencv package doesn't supply pkg-config atm
	  # so i forcing detection
	  sed -i -e "s|^facedetect_dep.*|facedetect_dep = dependency('opencv4', version: ['>=2.3.0'], required : true)|g" \
	  subprojects/shotwell-facedetect/meson.build
	fi
}
src_configure() {
	local emesonargs=(
	  -Dunity_support=false
	  -Ddupe_detection=true
	  -Dinstall_apport_hook=false
	  $(meson_use udev)
	  $(meson_use opencv face_detection)
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
