# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson gnome3

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas"
SRC_URI="https://download.gnome.org/sources/gsettings-desktop-schemas/49/gsettings-desktop-schemas-49.1.tar.xz -> gsettings-desktop-schemas-49.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="introspection? ( dev-libs/gobject-introspection:= )
	sys-devel/gettext
	virtual/pkgconfig
	
"
src_configure() {
	local emesonargs=(
	  $(meson_use introspection)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
