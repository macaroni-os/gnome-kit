# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic gnome3 meson systemd

DESCRIPTION="Indexer and search engine that powers desktop search for core GNOME components"
HOMEPAGE="https://gitlab.gnome.org/GNOME/localsearch"
SRC_URI="https://download.gnome.org/sources/localsearch/3.10/localsearch-3.10.2.tar.xz -> localsearch-3.10.2.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="cue exif gif gsf +gstreamer iptc +iso +jpeg +pdf +playlist raw
seccomp +tiff upower +xml xmp xps
"
REQUIRED_USE="cue? ( gstreamer )
"
BDEPEND="app-text/asciidoc
	dev-libs/libxslt
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="app-misc/tinysparql
	sys-apps/dbus
	xmp? ( media-libs/exempi:= )
	raw? ( media-libs/gexiv2 )
	dev-libs/glib:2
	dev-libs/libgudev
	dev-libs/gobject-introspection:=
	cue? ( media-libs/libcue:= )
	exif? ( media-libs/libexif )
	gsf? ( gnome-extra/libgsf )
	xps? ( app-text/libgxps )
	iptc? ( media-libs/libiptcdata )
	jpeg? ( media-libs/libjpeg-turbo:= )
	iso? ( sys-libs/libosinfo )
	media-libs/libpng:=
	tiff? ( media-libs/tiff:= )
	xml? ( dev-libs/libxml2:= )
	pdf? ( app-text/poppler:=[cairo] )
	playlist? ( dev-libs/totem-pl-parser:= )
	gif? ( media-libs/giflib:= )
	app-arch/gzip
	upower? ( sys-power/upower:= )
	dev-libs/icu:=
	gstreamer? (
	  media-libs/gstreamer:1.0
	  media-libs/gst-plugins-base:1.0
	)
	media-video/ffmpeg:0=
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	gnome3_environment_reset
}
src_configure() {
	append-cflags -DTRACKER_DEBUG -DG_DISABLE_CAST_CHECKS
	 local emesonargs=(
	  -Dman=true
	  -Dextract=true
	  -Dfunctional_tests=false
	  -Dtests_tap_protocol=false
	  -Dminer_fs=true
	  -Dwriteback=true
	  -Dabiword=true
	  -Dicon=true
	  -Dmp3=true
	  -Dps=true
	  -Dtext=true
	  -Dunzip_ps_gz_files=true # spawns gunzip
	  -Dlandlock=disabled
	  $(meson_feature cue)
	  $(meson_feature exif)
	  $(meson_feature gif)
	  $(meson_feature gsf)
	  $(meson_feature iptc)
	  $(meson_feature iso)
	  $(meson_feature jpeg)
	  $(meson_feature pdf)
	  $(meson_feature playlist)
	  -Dpng=enabled
	  $(meson_feature raw)
	  $(meson_feature tiff)
	  $(meson_feature xml)
	  $(meson_feature xmp)
	  $(meson_feature xps)
	  -Dbattery_detection=$(usex upower upower none)
	  -Dcharset_detection=icu
	  -Dsystemd_user_services_dir="$(systemd_get_userunitdir)"
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
