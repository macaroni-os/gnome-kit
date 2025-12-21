# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson systemd

DESCRIPTION="Gtk implementation of xdg-desktop-portal"
HOMEPAGE="https://github.com/flatpak/xdg-desktop-portal-gtk"
SRC_URI="https://github.com/flatpak/xdg-desktop-portal-gtk/releases/download/1.15.3/xdg-desktop-portal-gtk-1.15.3.tar.xz -> xdg-desktop-portal-gtk-1.15.3.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="wayland X"
BDEPEND="dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	gnome-base/gsettings-desktop-schemas
	media-libs/fontconfig
	sys-apps/dbus
	sys-apps/xdg-desktop-portal
	x11-libs/cairo[X?]
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[wayland?,X?]
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	# All backends that are disabled are instead provided by
	# xdg-desktop-portal-gnome to keep this package free of GNOME dependencies.
	# The appchooser and settings backends are enabled for non-GNOME GTK
	# applications.
	local emesonargs=(
	  -Dsystemd-user-unit-dir="$(systemd_get_userunitdir)"
	  -Dappchooser=enabled
	  -Dsettings=enabled
	  -Dlockdown=disabled
	  -Dwallpaper=disabled
	)
	meson_src_configure
}


# vim: filetype=ebuild
