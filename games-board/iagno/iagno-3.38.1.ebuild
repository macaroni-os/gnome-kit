# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson vala

DESCRIPTION="Dominate the board in a classic version of Reversi"
HOMEPAGE="https://gitlab.gnome.org/GNOME/iagno"
SRC_URI="https://download.gnome.org/sources/iagno/3.38/iagno-3.38.1.tar.xz -> iagno-3.38.1.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/iagno-3.35.90-posix.patch"
	"${FILESDIR}/iagno_508c0f94e5f182e50ff61be6e04f72574dee97cb.patch"
	"${FILESDIR}/iagno_e8a0aeec350ea80349582142c0e8e3cd3f1bce38.patch"
)
BDEPEND="$(vala_depend)
	app-text/yelp-tools
	dev-util/itstool
	dev-libs/appstream-glib
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	media-libs/gsound[vala]
	gnome-base/librsvg[vala]
	x11-libs/gtk+:3
	media-libs/libcanberra[gtk3]
	
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
