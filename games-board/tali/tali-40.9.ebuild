# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Beat the odds in a poker-style dice game"
HOMEPAGE="https://gitlab.gnome.org/GNOME/tali"
SRC_URI="https://download.gnome.org/sources/tali/40/tali-40.9.tar.xz -> tali-40.9.tar.xz"
LICENSE="GPL-2+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/itstool
	dev-libs/appstream-glib
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3
	dev-libs/libgnome-games-support:1=
	
"
DEPEND="${RDEPEND}
"
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
