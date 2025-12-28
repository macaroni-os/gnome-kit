# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="NetworkManager connection editor and applet"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
SRC_URI="https://download.gnome.org/sources/network-manager-applet/1.36/network-manager-applet-1.36.0.tar.xz -> network-manager-applet-1.36.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="appindicator +modemmanager teamd"
BDEPEND="dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	app-crypt/libsecret
	net-libs/libnma
	x11-libs/gtk+:3
	net-misc/networkmanager[modemmanager?,teamd?]
	appindicator? (
	  dev-libs/libayatana-appindicator
	  dev-libs/libdbusmenu
	)
	modemmanager? ( net-misc/modemmanager )
	teamd? ( dev-libs/jansson:= )
	virtual/freedesktop-icon-theme
	
"
DEPEND="${RDEPEND}
"
post_src_unpack() {
	mv network-manager-applet-* "${S}"
}
src_configure() {
	local emesonargs=(
	  -Dappindicator=$(usex appindicator ayatana no)
	  $(meson_use modemmanager wwan)
	  $(meson_use teamd team)
	  -Dmore_asserts=0
	  -Dselinux=false
	  -Dld_gc=false
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
