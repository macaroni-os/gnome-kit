# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1 vala

DESCRIPTION="Turn off all the lights"
HOMEPAGE="https://gitlab.gnome.org/GNOME/lightsoff"
SRC_URI="https://download.gnome.org/sources/lightsoff/48/lightsoff-48.1.tar.xz -> lightsoff-48.1.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	dev-libs/appstream
	dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	gnome-base/librsvg[vala]
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
