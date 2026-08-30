# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 systemd vala xdg user

DESCRIPTION="Location information D-Bus service"
HOMEPAGE="https://gitlab.freedesktop.org/geoclue/geoclue/-/wikis/home"
SRC_URI="https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/2.8.1/geoclue-2.8.1.tar.bz2 -> geoclue-2.8.1.tar.bz2"
LICENSE="LGPL-2.1+ GPL-2+"
SLOT="2.0"
KEYWORDS="*"
IUSE="+introspection gtk-doc modemmanager vala zeroconf"
BDEPEND="${PYTHON_DEPS}
	dev-util/gdbus-codegen
	gtk-doc? (
	  app-text/docbook-xml-dtd:4.1.2
	  dev-util/gtk-doc
	)
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	net-libs/libsoup:3
	introspection? ( dev-libs/gobject-introspection:= )
	modemmanager? ( net-misc/modemmanager )
	zeroconf? ( net-dns/avahi )
	x11-libs/libnotify
	sys-apps/dbus
	
"
DEPEND="${RDEPEND}
"
pkg_preinst() {
	enewgroup geoclue
	enewuser geoclue -1 -1 /var/lib/geoclue geoclue
}
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dlibgeoclue=true
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc)
	  $(meson_use modemmanager 3g-source)
	  $(meson_use modemmanager cdma-source)
	  $(meson_use modemmanager modem-gps-source)
	  $(meson_use zeroconf nmea-source)
	  -Dcompass=true
	  -Denable-backend=true
	  -Ddemo-agent=true
	  -Dsystemd-system-unit-dir="$(systemd_get_systemunitdir)"
	  -Ddbus-srv-user=geoclue
	)
	meson_src_configure
}


# vim: filetype=ebuild
