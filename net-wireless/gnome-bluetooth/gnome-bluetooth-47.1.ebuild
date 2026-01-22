# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1

DESCRIPTION="Bluetooth graphical utilities integrated with GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-bluetooth"
SRC_URI="https://download.gnome.org/sources/gnome-bluetooth/47/gnome-bluetooth-47.1.tar.xz -> gnome-bluetooth-47.1.tar.xz"
LICENSE="GPL-2+"
SLOT="3"
KEYWORDS="*"
IUSE="gtk-doc +introspection sendto"
BDEPEND="${PYTHON_DEPS}
	dev-libs/libxml2:2
	dev-util/gdbus-codegen
	gtk-doc? ( dev-util/gtk-doc )
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	x11-libs/libnotify
	media-libs/gsound
	sys-power/upower:=
	virtual/libudev:=
	virtual/udev
	introspection? ( dev-libs/gobject-introspection:= )
	net-wireless/bluez
	!net-wireless/gnome-bluetooth:2/13
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_configure() {
	local emesonargs=(
	  $(meson_use sendto)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}


# vim: filetype=ebuild
