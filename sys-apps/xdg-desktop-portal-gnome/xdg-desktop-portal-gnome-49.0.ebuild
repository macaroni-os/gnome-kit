# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson systemd

DESCRIPTION=""
HOMEPAGE="https://gitlab.gnome.org/GNOME/xdg-desktop-portal-gnome"
SRC_URI="https://download.gnome.org/sources/xdg-desktop-portal-gnome/49/xdg-desktop-portal-gnome-49.0.tar.xz -> xdg-desktop-portal-gnome-49.0.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="wayland X"
BDEPEND="dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	wayland? ( dev-util/wayland-scanner )
	
"
RDEPEND="dev-libs/glib:2
	>=gnome-base/gsettings-desktop-schemas-49
	gnome-base/gnome-desktop
	x11-libs/libadwaita
	media-libs/fontconfig
	sys-apps/dbus
	sys-apps/xdg-desktop-portal
	sys-apps/xdg-desktop-portal-gtk
	x11-libs/gtk:4[wayland?,X?]
	wayland? ( dev-libs/wayland )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dsystemduserunitdir="$(systemd_get_userunitdir)"
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
