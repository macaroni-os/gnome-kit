# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Move tiles so that they reach their places"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-taquin"
SRC_URI="https://download.gnome.org/sources/gnome-taquin/3.38/gnome-taquin-3.38.1.tar.xz -> gnome-taquin-3.38.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/taquin_66be44dc20d114e449fc33156e3939fd05dfbb16.patch"
	"${FILESDIR}/taquin_99dea5e7863e112f33f16e59898c56a4f1a547b3.patch"
)
BDEPEND="dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	media-libs/gsound[vala]
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf:2
	gnome-base/librsvg[vala]
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
