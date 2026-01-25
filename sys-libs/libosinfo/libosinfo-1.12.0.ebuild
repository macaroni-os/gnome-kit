# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala xdg

DESCRIPTION="GObject library for managing information about real and virtual OSes"
HOMEPAGE="https://libosinfo.org/"
SRC_URI="https://releases.pagure.org/libosinfo/libosinfo-1.12.0.tar.xz -> libosinfo-1.12.0.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/libosinfo-1.12.0-libxml2-2.14.patch"
)
IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="dev-lang/perl
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	net-libs/libsoup:3
	dev-libs/libxml2:=
	dev-libs/libxslt
	sys-apps/hwdata
	sys-apps/osinfo-db
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	sys-apps/osinfo-db-tools
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk-doc enable-gtk-doc)
	  $(meson_feature introspection enable-introspection)
	  $(meson_feature vala enable-vala)
	  -Denable-tests=false
	  -Dlibsoup-abi=3.0
	  -Dwith-pci-ids-path="${EPREFIX}"/usr/share/hwdata/pci.ids
	  -Dwith-usb-ids-path="${EPREFIX}"/usr/share/hwdata/usb.ids
	)
	meson_src_configure
}


# vim: filetype=ebuild
