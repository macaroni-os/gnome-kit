# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg

DESCRIPTION="Adwaita Icon Theme legacy"
HOMEPAGE="https://gitlab.gnome.org/GNOME/adwaita-icon-theme-legacy"
SRC_URI="https://download.gnome.org/sources/adwaita-icon-theme-legacy/46/adwaita-icon-theme-legacy-46.2.tar.xz -> adwaita-icon-theme-legacy-46.2.tar.xz"
LICENSE="LGPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	dev-util/gtk-update-icon-cache
	
"
RDEPEND="x11-themes/hicolor-icon-theme
	gnome-base/librsvg:2
	
"
DEPEND="${RDEPEND}
"
src_install() {
	meson_src_install
	# https://gitlab.gnome.org/GNOME/adwaita-icon-theme-legacy/-/issues/3
	mv "${ED}"/usr/share/licenses/adwaita-icon-theme \
	  "${ED}"/usr/share/licenses/adwaita-icon-theme-legacy || die
}


# vim: filetype=ebuild
