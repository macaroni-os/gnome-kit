# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3

DESCRIPTION="GNOME docking library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gdl"
SRC_URI="https://download.gnome.org/sources/gdl/3.40/gdl-3.40.0.tar.xz -> gdl-3.40.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="3/5"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="dev-util/intltool
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	dev-libs/libxml2:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	
"
src_configure() {
	gnome3_src_configure \
	  $(use_enable introspection) \
	  --disable-gtk-doc
}


# vim: filetype=ebuild
