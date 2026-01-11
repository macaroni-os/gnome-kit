# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Library for code common to GNOME games"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgnome-games-support"
SRC_URI="https://download.gnome.org/sources/libgnome-games-support/1.8/libgnome-games-support-1.8.2.tar.xz -> libgnome-games-support-1.8.2.tar.xz"
LICENSE="LGPL-3+"
SLOT="1"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/libgee:=
	dev-libs/glib:2
	x11-libs/gtk+:3
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_src_prepare
}


# vim: filetype=ebuild
