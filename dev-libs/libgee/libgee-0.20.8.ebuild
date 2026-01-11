# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 vala

DESCRIPTION="GObject-based interfaces and classes for commonly used data structures"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgee"
SRC_URI="https://download.gnome.org/sources/libgee/0.20/libgee-0.20.8.tar.xz -> libgee-0.20.8.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0.8/2"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	$(vala_depend)
	
"
src_prepare() {
	vala_src_prepare
	gnome3_src_prepare
}
src_configure() {
	gnome3_src_configure \
	  $(use_enable introspection)
}


# vim: filetype=ebuild
