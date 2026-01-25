# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="GNOME power statistics"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-power-manager"
SRC_URI="https://download.gnome.org/sources/gnome-power-manager/43/gnome-power-manager-43.0.tar.xz -> gnome-power-manager-43.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
# Commons depends
CDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/cairo
	sys-power/upower:=
	
"
BDEPEND="app-text/docbook-sgml-dtd:4.1
	app-text/docbook-sgml-utils
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	x11-themes/adwaita-icon-theme
	
"
DEPEND="${CDEPEND}
	x11-base/xorg-proto
	
"
src_configure() {
	local emesonargs=(
	  -Denable-tests=false
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
