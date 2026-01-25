# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 python-any-r1 virtualx meson

DESCRIPTION="A weather application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Design/Apps/Weather"
SRC_URI="https://download.gnome.org/sources/gnome-weather/49/gnome-weather-49.0.tar.xz -> gnome-weather-49.0.tar.xz"
LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
RDEPEND="app-misc/geoclue:2.0
	dev-libs/gjs
	dev-libs/glib:2
	dev-libs/gobject-introspection:=
	dev-libs/libgweather:=
	gnome-base/gsettings-desktop-schemas
	x11-libs/gtk:4
	
"
DEPEND="${RDEPEND}
	dev-libs/appstream-glib
	dev-node/typescript
	dev-util/intltool
	virtual/pkgconfig
	
"
src_configure() {
	meson_src_configure -Dprofile=default -Ddogtail=false
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_posrm
}


# vim: filetype=ebuild
