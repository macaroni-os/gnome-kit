# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson vala

DESCRIPTION=""
SRC_URI="https://gitlab.gnome.org/GNOME/libnma/-/archive/1.10.6/libnma-1.10.6.tar.bz2 -> libnma-1.10.6.tar.bz2"
LICENSE="GPL-2+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gcr +gtk4 +introspection +vala"
RDEPEND="app-text/iso-codes
	net-misc/mobile-broadband-provider-info
	dev-libs/glib:2[dbus]
	dev-libs/gobject-introspection:=
	x11-libs/gtk+:3[introspection?]
	gtk4? (
	  x11-libs/gtk:4[introspection?]
	)
	gcr? (
	  app-crypt/gcr:=[gtk]
	)
	net-misc/networkmanager[vala?]
	
"
DEPEND="${RDEPEND}
	$(vala_depend)
	
"
S="${WORKDIR}/libnma-1.10.6"
src_prepare() {
	vala_src_prepare
	gnome3_src_prepare
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk4 libnma_gtk4)
	  $(meson_use gcr)
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}


# vim: filetype=ebuild
