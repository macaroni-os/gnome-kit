# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="CD/DVD burning application for the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/brasero"
SRC_URI="https://download.gnome.org/sources/brasero/3.12/brasero-3.12.3.tar.xz -> brasero-3.12.3.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0/3.1"
KEYWORDS="*"
IUSE="+css +introspection +libburn mp3 nautilus playlist tracker"
BDEPEND="dev-util/intltool
	dev-util/itstool
	dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${RDEPEND}
	media-libs/gst-plugins-good:1.0
	media-plugins/gst-plugins-meta:1.0[mp3?]
	x11-themes/hicolor-icon-theme
	!libburn? (
	  app-cdr/cdrdao
	  app-cdr/cdrtools
	  app-cdr/dvd+rw-tools
	)
	
"
DEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	dev-libs/libxml2:=
	x11-libs/libnotify:=
	media-libs/libcanberra
	x11-libs/libICE
	x11-libs/libSM
	introspection? ( dev-libs/gobject-introspection:= )
	libburn? (
	  dev-libs/libburn:=
	  dev-libs/libisofs:=
	)
	nautilus? ( gnome-base/nautilus )
	playlist? ( dev-libs/totem-pl-parser:= )
	tracker? ( app-misc/tinysparql:= )
	
"
PDEPEND="gnome-base/gvfs
	
"
src_configure() {
	gnome3_src_configure \
	  --disable-caches \
	  $(use_enable !libburn cdrtools) \
	  $(use_enable !libburn cdrkit) \
	  $(use_enable !libburn cdrdao) \
	  $(use_enable !libburn growisofs) \
	  $(use_enable introspection) \
	  $(use_enable libburn libburnia) \
	  $(use_enable nautilus) \
	  $(use_enable playlist) \
	  $(use_enable tracker search)
}


# vim: filetype=ebuild
