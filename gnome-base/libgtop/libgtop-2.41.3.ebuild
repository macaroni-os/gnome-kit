# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgtop"
SRC_URI="https://download.gnome.org/sources/libgtop/2.41/libgtop-2.41.3.tar.xz -> libgtop-2.41.3.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2/11"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	gnome3_src_configure \
	  --disable-static \
	  $(use_enable introspection)
}


# vim: filetype=ebuild
