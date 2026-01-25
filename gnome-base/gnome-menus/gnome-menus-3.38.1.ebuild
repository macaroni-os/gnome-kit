# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="Library and layout configuration for the Desktop Menu fd.o specification"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-menus"
SRC_URI="https://download.gnome.org/sources/gnome-menus/3.38/gnome-menus-3.38.1.tar.xz -> gnome-menus-3.38.1.tar.xz"
LICENSE="GPL-2+ LGPL-2+"
SLOT="3"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog
	HACKING
	NEWS
	README
)
IUSE="+introspection"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	gnome3_src_configure \
	  $(use_enable introspection) \
	  --disable-static
}


# vim: filetype=ebuild
