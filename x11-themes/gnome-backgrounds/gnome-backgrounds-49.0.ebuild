# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="A set of backgrounds packaged with the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-backgrounds"
SRC_URI="https://download.gnome.org/sources/gnome-backgrounds/49/gnome-backgrounds-49.0.tar.xz -> gnome-backgrounds-49.0.tar.xz"
LICENSE="CC-BY-SA-2.0 CC-BY-SA-3.0 CC-BY-2.0 CC-BY-4.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="media-libs/libjxl[gdk-pixbuf]
	gnome-base/librsvg
	x11-libs/gdk-pixbuf[jpeg]
	
"

# vim: filetype=ebuild
