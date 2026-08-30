# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="https://gitlab.gnome.org/GNOME/zenity"
SRC_URI="https://download.gnome.org/sources/zenity/4.2/zenity-4.2.2.tar.xz -> zenity-4.2.2.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="man webkit"
BDEPEND="dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="x11-libs/libadwaita
	webkit? ( net-libs/webkit-gtk:6 )
	man? ( sys-apps/help2man )
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_use webkit webkitgtk)
	  $(meson_use man manpage)
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
