# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson flag-o-matic python-any-r1 xdg

DESCRIPTION="GNOME's main interface to configure various aspects of the desktop"
HOMEPAGE="https://apps.gnome.org/Settings"
SRC_URI="https://download.gnome.org/sources/gnome-control-center/49/gnome-control-center-49.2.2.tar.xz -> gnome-control-center-49.2.2.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-2.5"
SLOT="2"
KEYWORDS="*"
IUSE="X +bluetooth +cups debug elogind +gnome-online-accounts +ibus input_devices_wacom
kerberos +geolocation networkmanager systemd wayland
"
REQUIRED_USE="^^ ( elogind systemd )
"
BDEPEND="${PYTHON_DEPS}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.2
	x11-base/xorg-proto
	dev-libs/libxml2:2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="gnome-online-accounts? (
	  x11-libs/gtk+:3[X,wayland]
	  net-libs/gnome-online-accounts:=
	)
	media-sound/pulseaudio[glib]
	x11-libs/gtk:4[X,wayland]
	x11-libs/libadwaita
	sys-apps/accountsservice
	x11-misc/colord:=
	x11-libs/gdk-pixbuf
	dev-libs/glib:2
	gnome-base/gnome-desktop:=
	>=gnome-base/gnome-settings-daemon-49[colord,input_devices_wacom?]
	>=gnome-base/gsettings-desktop-schemas-49
	dev-libs/libxml2:2=
	sys-power/upower:=
	dev-libs/libgudev
	x11-libs/libX11
	x11-libs/libXi
	media-libs/libepoxy
	app-crypt/gcr
	dev-libs/libpwquality
	sys-auth/polkit
	cups? (
	  net-print/cups[dbus]
	  net-fs/samba[client]
	)
	ibus? ( app-i18n/ibus )
	networkmanager? (
	  net-libs/libnma[gtk4]
	  net-misc/networkmanager[modemmanager]
	  net-misc/modemmanager:=
	)
	bluetooth? ( net-wireless/gnome-bluetooth:= )
	input_devices_wacom? ( dev-libs/libwacom:= )
	kerberos? ( app-crypt/mit-krb5 )
	x11-libs/cairo[glib]
	x11-libs/colord-gtk:=
	media-libs/fontconfig
	gnome-base/libgtop:=
	sys-fs/udisks:2
	app-crypt/libsecret
	net-libs/gnutls:=
	media-libs/gsound
	x11-libs/pango
	media-libs/libcanberra[pulseaudio,sound(+)]
	systemd? ( sys-apps/systemd )
	elogind? (
	  app-admin/openrc-settingsd
	  sys-auth/elogind
	)
	x11-themes/adwaita-icon-theme
	gnome-extra/gnome-color-manager
	cups? (
	  app-admin/system-config-printer
	  net-print/cups-pk-helper
	)
	gnome-extra/tecla
	wayland? ( dev-libs/libinput )
	!wayland? (
	  x11-drivers/xf86-input-libinput
	  input_devices_wacom? ( x11-drivers/xf86-input-wacom )
	)
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_prepare() {
	default
	xdg_environment_reset
}
src_configure() {
	# Do not trust with LTO either
	append-flags -fno-strict-aliasing
	filter-lto
	local emesonargs=(
	  $(meson_use X x11)
	  $(meson_use ibus)
	  -Ddeprecated-declarations=disabled
	  -Ddocumentation=true # manpage
	  -Dlocation-services=$(usex geolocation enabled disabled)
	  -Dprivileged_group=wheel
	  -Dsnap=false
	  -Dtests=false
	  -Dmalcontent=false # unpackaged
	  -Ddistributor_logo=/usr/share/pixmaps/gnome-control-center-macaroni-logo.svg
	  -Ddark_mode_distributor_logo=/usr/share/pixmaps/gnome-control-center-macaroni-logo-dark.svg
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/gnome-control-center-macaroni-logo.svg
	doins "${FILESDIR}"/gnome-control-center-macaroni-logo-dark.svg
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
