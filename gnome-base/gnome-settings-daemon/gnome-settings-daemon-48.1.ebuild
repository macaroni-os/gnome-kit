# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1 udev xdg

DESCRIPTION="Gnome Settings Daemon"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-settings-daemon"
SRC_URI="https://download.gnome.org/sources/gnome-settings-daemon/48/gnome-settings-daemon-48.1.tar.xz -> gnome-settings-daemon-48.1.tar.xz"
LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+colord +cups elogind +input_devices_wacom modemmanager +networkmanager
smartcard systemd wayland
"
REQUIRED_USE="^^ ( elogind systemd )
"
RDEPEND="sci-geosciences/geocode-glib
	dev-libs/glib:2
	gnome-base/gnome-desktop:=
	>=gnome-base/gsettings-desktop-schemas-48
	x11-libs/gtk+:3[X,wayland?]
	dev-libs/libgweather:=
	colord? ( x11-misc/colord:= )
	media-libs/libcanberra[gtk3(-)]
	app-misc/geoclue
	x11-libs/libnotify
	media-sound/pulseaudio[glib]
	sys-auth/polkit
	sys-power/upower:=
	x11-libs/libX11
	x11-libs/libXfixes
	dev-libs/libgudev:=
	wayland? ( dev-libs/wayland )
	input_devices_wacom? (
	  dev-libs/libwacom:=
	  x11-libs/pango
	  x11-libs/gdk-pixbuf:2
	)
	smartcard? ( app-crypt/gcr:= )
	cups? ( net-print/cups[dbus] )
	modemmanager? (
	  app-crypt/gcr
	  net-misc/modemmanager:=
	)
	networkmanager? ( net-misc/networkmanager )
	media-libs/alsa-lib
	x11-libs/libXi
	x11-libs/libXext
	media-libs/fontconfig
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	sys-apps/usbguard
	
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_configure() {
	local emesonargs=(
	  -Dudev_dir="$(get_udevdir)"
	  -Dalsa=true
	  -Dgudev=true
	  -Dgcr3=false
	  -Drfkill=true
	  -Dx11=true
	  $(meson_use systemd)
	  $(meson_use elogind)
	  $(meson_use colord)
	  $(meson_use cups)
	  $(meson_use networkmanager network_manager)
	  $(meson_use smartcard)
	  $(meson_use wayland xwayland)
	  $(meson_use modemmanager wwan)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# Don't auto-suspend by default on AC power
	insinto /usr/share/glib-2.0/schemas
	doins "${FILESDIR}"/org.gnome.settings-daemon.plugins.power.gschema.override
}
pkg_postinst() {
	udev_reload
	gnome3_pkg_postinst
}
pkg_postrm() {
	udev_reload
	gnome3_pkg_postinst
}


# vim: filetype=ebuild
