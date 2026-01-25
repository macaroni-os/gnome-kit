# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Make lines of the same color to win"
HOMEPAGE="https://gitlab.gnome.org/GNOME/four-in-a-row"
SRC_URI="https://download.gnome.org/sources/four-in-a-row/3.38/four-in-a-row-3.38.1.tar.xz -> four-in-a-row-3.38.1.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	media-libs/gsound[vala]
	gnome-base/librsvg[vala]
	x11-libs/gtk+:3
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	gnome3_src_prepare
	vala_src_prepare
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
