# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="Mouse accessibility enhancements for the GNOME desktop"
HOMEPAGE="https://live.gnome.org/Mousetweaks/Home"
SRC_URI="https://download.gnome.org/sources/mousetweaks/3.32/mousetweaks-3.32.0.tar.xz -> mousetweaks-3.32.0.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXfixes
	x11-libs/libXcursor
	gnome-base/gsettings-desktop-schemas
	
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	
"

# vim: filetype=ebuild
