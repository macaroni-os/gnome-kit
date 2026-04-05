# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3-utils meson xdg-utils

DESCRIPTION="A GNOME Shell extension for providing desktop icons (GTK4 Fork)"
HOMEPAGE="https://gitlab.com/smedius/desktop-icons-ng"
SRC_URI="https://gitlab.com/smedius/desktop-icons-ng/-/archive/Gtk4-100.19/desktop-icons-ng-Gtk4-100.19.tar.bz2 -> gnome-shell-extension-desktop-icons-gtk4-100.19.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	app-eselect/eselect-gnome-shell-extensions
	gnome-base/gnome-shell
	gnome-base/nautilus
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/desktop-icons-ng-Gtk4-100.19"
pkg_preinst() {
	gnome3_schemas_savelist
}
pkg_postinst() {
	gnome3_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
	xdg_icon_cache_update
}
pkg_postrm() {
	gnome3_schemas_update
	xdg_icon_cache_update
}


# vim: filetype=ebuild
