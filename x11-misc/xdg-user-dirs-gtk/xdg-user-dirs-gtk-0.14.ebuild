# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Integrates xdg-user-dirs into the Gnome desktop and Gtk+ applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/xdg-user-dirs-gtk"
SRC_URI="https://download.gnome.org/sources/xdg-user-dirs-gtk/0.14/xdg-user-dirs-gtk-0.14.tar.xz -> xdg-user-dirs-gtk-0.14.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3
	x11-misc/xdg-user-dirs
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	sed -i \
	  -e '/Encoding/d' \
	  -e 's:OnlyShowIn=GNOME;LXDE;Unity;:NotShowIn=KDE;:' \
	  user-dirs-update-gtk.desktop.in || die
}


# vim: filetype=ebuild
