# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg

DESCRIPTION="JavaScript extensions for GNOME Shell"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-shell-extensions"
SRC_URI="https://download.gnome.org/sources/gnome-shell-extensions/49/gnome-shell-extensions-49.0.tar.xz -> gnome-shell-extensions-49.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="X"
# Commons depends
CDEPEND="dev-libs/glib:2
	gnome-base/libgtop[introspection]
	app-eselect/eselect-gnome-shell-extensions
	
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	>=gnome-base/gnome-shell-49
	app-accessibility/at-spi2-core[introspection]
	dev-libs/gjs
	dev-libs/gobject-introspection:=
	gnome-base/gnome-menus[introspection]
	x11-libs/libadwaita[introspection]
	media-libs/clutter:1.0[introspection]
	media-libs/graphene[introspection]
	x11-libs/gtk+:3[introspection]
	x11-themes/adwaita-icon-theme
	x11-wm/mutter[introspection]
	
"
DEPEND="${CDEPEND}
"
rc_configure() {
	local emesonargs=(
	  -Dextension_set=all
	  -Dclassic_mode=true
	  $(meson_use X x11)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	xdg_pkg_postinst
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}


# vim: filetype=ebuild
