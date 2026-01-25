# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Mind game - build molecules out of single atoms"
HOMEPAGE="https://gitlab.gnome.org/GNOME/atomix"
SRC_URI="https://download.gnome.org/sources/atomix/44/atomix-44.0.tar.xz -> atomix-44.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="x11-libs/gtk+:3
	x11-libs/gdk-pixbuf:2
	dev-libs/glib:2
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
