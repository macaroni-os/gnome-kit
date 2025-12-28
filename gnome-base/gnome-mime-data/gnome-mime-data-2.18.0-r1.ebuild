# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="MIME data for Gnome"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-mime-data"
SRC_URI="https://download.gnome.org/sources/gnome-mime-data/2.18/gnome-mime-data-2.18.0.tar.bz2 -> gnome-mime-data-2.18.0.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	dev-util/intltool
	
"
src_prepare() {
	intltoolize --force || die "intltoolize failed"
	gnome3_src_prepare
}


# vim: filetype=ebuild
