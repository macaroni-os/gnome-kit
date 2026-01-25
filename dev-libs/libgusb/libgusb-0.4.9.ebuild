# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND=vapigen
inherit meson vala

DESCRIPTION="GUsb is a GObject wrapper for libusb1"
HOMEPAGE="https://github.com/hughsie/libgusb"
SRC_URI="https://github.com/hughsie/libgusb/releases/download/0.4.9/libgusb-0.4.9.tar.xz -> libgusb-0.4.9-ed31c81.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="vala? ( $(vala_depend) )
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	virtual/libusb:1[udev]
	dev-libs/json-glib[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	sys-apps/hwdata
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  -Dtests=false
	  -Dumockdev=disabled
	  -Ddocs=false
	  $(meson_use vala vapi)
	  $(meson_use introspection)
	  -Dusb_ids="${EPREFIX}"/usr/share/hwdata/usb.ids
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
