# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="GNOME calendars interface"
HOMEPAGE="https://apps.gnome.org/Calendar/"
SRC_URI="https://download.gnome.org/sources/gnome-calendar/49/gnome-calendar-49.0.1.tar.xz -> gnome-calendar-49.0.1.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream-glib
	dev-libs/libxml2
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libical:=
	gnome-base/gsettings-desktop-schemas
	gnome-extra/evolution-data-server:=[gtk]
	net-libs/libsoup:3
	x11-libs/libadwaita
	dev-libs/glib:2
	x11-libs/gtk:4
	dev-libs/libgweather:=
	app-misc/geoclue
	
"
DEPEND="${RDEPEND}
"
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
