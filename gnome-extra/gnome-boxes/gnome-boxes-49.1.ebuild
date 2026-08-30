# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Simple GNOME application to access remote or virtual systems"
HOMEPAGE="https://apps.gnome.org/Boxes/"
SRC_URI="https://download.gnome.org/sources/gnome-boxes/49/gnome-boxes-49.1.tar.xz -> gnome-boxes-49.1.tar.xz"
LICENSE="LGPL-2+ CC-BY-2.0"
SLOT="0"
KEYWORDS="*"
# Commons depends
CDEPEND="app-emulation/libvirt-glib[vala]
	app-arch/libarchive:=
	dev-libs/glib:2
	x11-libs/gtk+:3
	dev-libs/libportal[gtk]
	dev-libs/gobject-introspection:=
	dev-libs/libgudev:=
	dev-libs/libhandy
	dev-libs/libxml2:=
	sys-libs/libosinfo[vala]
	net-libs/libsoup:3[vala]
	net-misc/spice-gtk[gtk+(+),smartcard,usbredir]
	net-libs/webkit-gtk:4
	virtual/libusb:1
	
"
BDEPEND="$(vala_depend)
	app-crypt/libsecret[vala]
	x11-libs/vte:2.91[vala]
	dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	app-cdr/cdrtools
	app-misc/localsearch[iso]
	app-emulation/spice[smartcard]
	app-emulation/libvirt[libvirtd,qemu]
	app-emulation/qemu
	sys-fs/mtools
	sys-auth/polkit
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Ddistributor_name=MacaroniOS
	  -Ddistributor_version=49.1
	  -Dinstalled_tests=false
	  -Dflatpak=false
	  -Dprofile=default
	  -Duefi=true
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
