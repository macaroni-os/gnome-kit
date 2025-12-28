# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Clocks application for GNOME"
HOMEPAGE="https://apps.gnome.org/Clocks/"
SRC_URI="https://download.gnome.org/sources/gnome-clocks/49/gnome-clocks-49.0.tar.xz -> gnome-clocks-49.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS.md
	CONTRIBUTING.md
	README.md
)
BDEPEND="dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib
	x11-libs/gtk:4
	x11-libs/libadwaita[vala]
	dev-libs/libgweather:=[vala]
	gnome-base/gnome-desktop
	sci-geosciences/geocode-glib
	app-misc/geoclue
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dprofile=default
	  -Ddocs=false
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
