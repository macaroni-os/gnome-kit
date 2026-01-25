# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Access, organize and share your photos on GNOME"
HOMEPAGE="https://gitlab.gnome.org/Archive/gnome-photos"
SRC_URI="https://download.gnome.org/sources/gnome-photos/44/gnome-photos-44.0.tar.xz -> gnome-photos-44.0.tar.xz"
LICENSE="GPL-3+ LGPL-2+ CC0-1.0"
SLOT="0"
KEYWORDS="*"
IUSE="upnp-av"
# Commons depends
CDEPEND="media-libs/babl
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	media-libs/gegl[cairo,raw]
	sci-geosciences/geocode-glib
	media-libs/gexiv2
	dev-libs/glib:2
	dev-libs/libportal:=[gtk]
	net-libs/gnome-online-accounts:=
	gnome-base/gsettings-desktop-schemas
	x11-libs/gtk+:3
	dev-libs/libdazzle
	dev-libs/libhandy
	media-libs/libjpeg-turbo:=
	app-misc/tinysparql
	sys-apps/dbus
	
"
BDEPEND="dev-libs/appstream-glib
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	dev-util/desktop-file-utils
	dev-util/gdbus-codegen
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	upnp-av? ( net-libs/dleyna:= )
	app-misc/localsearch
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	gnome3_environment_reset
	sed -i -e "/photos_docdir.*=.*join_paths/s/meson.project_name()/'${PF}'/" meson.build
}
src_configure() {
	local emesonargs=(
	  -Dflatpak=false
	  -Dinstalled_tests=false
	  -Dmanuals=true
	  -Ddogtail=false
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
