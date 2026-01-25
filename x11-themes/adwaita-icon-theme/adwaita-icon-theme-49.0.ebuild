# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg

DESCRIPTION="GNOME default icon theme"
HOMEPAGE="https://gitlab.gnome.org/GNOME/adwaita-icon-theme"
SRC_URI="https://download.gnome.org/sources/adwaita-icon-theme/49/adwaita-icon-theme-49.0.tar.xz -> adwaita-icon-theme-49.0.tar.xz"
LICENSE="|| ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	dev-util/gtk-update-icon-cache
	
"
RDEPEND="x11-themes/hicolor-icon-theme
	gnome-base/librsvg:2
	x11-themes/adwaita-icon-theme-legacy
	
"
src_install() {
	meson_src_install
	dosym ../../../../usr/share/icons/Adwaita/cursors /usr/share/cursors/xorg-x11/Adwaita
}
pkg_preinst() {
	# Needed until bug #834600 is solved
	if [[ -d "${EROOT}"/usr/share/cursors/xorg-x11/Adwaita ]] ; then
	  rm -r "${EROOT}"/usr/share/cursors/xorg-x11/Adwaita || die
	fi
	xdg_pkg_preinst
}


# vim: filetype=ebuild
