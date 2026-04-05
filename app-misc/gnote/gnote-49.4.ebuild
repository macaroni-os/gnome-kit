# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnote"
SRC_URI="https://download.gnome.org/sources/gnote/49/gnote-49.4.tar.xz -> gnote-49.4.tar.xz"
LICENSE="GPL-3+ FDL-1.1"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/itstool
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2[dbus]
	dev-cpp/glibmm:2.68
	dev-cpp/gtkmm:4.0
	x11-libs/libadwaita
	app-crypt/libsecret
	dev-libs/libxml2:=
	dev-libs/libxslt
	sys-apps/util-linux
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	# disable tests
	sed -i -e "/unit_test_pp/ s/ = .*/ = disabler()/" meson.build || die
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
