# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Color profile manager for the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-color-manager"
SRC_URI="https://download.gnome.org/sources/gnome-color-manager/3.36/gnome-color-manager-3.36.2.tar.xz -> gnome-color-manager-3.36.2.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="exiv"
RDEPEND="dev-libs/glib:2
	media-libs/lcms:2
	media-libs/libcanberra
	media-libs/libexif
	media-libs/tiff:=
	x11-libs/gtk+:3
	x11-libs/vte:2.91
	x11-misc/colord:=
	x11-libs/colord-gtk
	exiv? ( media-gfx/exiv2:= )
	
"
DEPEND="${RDEPEND}
	media-gfx/exiv2
	app-text/docbook-sgml-dtd:4.1
	app-text/docbook-sgml-utils
	dev-libs/appstream-glib
	dev-libs/libxslt
	dev-util/intltool
	dev-util/itstool
	virtual/pkgconfig
	
"
src_configure() {
	local emesonargs=(
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
