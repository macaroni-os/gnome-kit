# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Simple GObject game controller library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libmanette"
SRC_URI="https://download.gnome.org/sources/libmanette/0.2/libmanette-0.2.13.tar.xz -> libmanette-0.2.13.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="doc +introspection +udev +vala"
REQUIRED_USE="vala? ( introspection ) doc? ( introspection )"
BDEPEND="doc? ( dev-util/gi-docgen )
	vala? (
	  $(vala_depend)
	)
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	udev? ( dev-libs/libgudev[introspection?] )
	dev-libs/libevdev
	dev-libs/hidapi
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Ddemos=false
	  -Dbuild-tests=false
	  -Dinstall-tests=false
	  $(meson_use doc doc)
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_feature udev gudev)
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
