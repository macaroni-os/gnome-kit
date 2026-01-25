# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
GNOME3_EAUTORECONF=yes
inherit gnome3

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="https://developer.gnome.org/gsf/"
SRC_URI="https://download.gnome.org/sources/libgsf/1.14/libgsf-1.14.55.tar.xz -> libgsf-1.14.55.tar.xz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="bzip2 gtk +introspection"
BDEPEND="sys-devel/gettext
	dev-util/gtk-doc-am
	dev-util/intltool
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	gtk? (
	  x11-libs/gdk-pixbuf:2
	  media-gfx/imagemagick
	)
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	gnome3_src_configure \
	  --disable-static \
	  $(use_with bzip2 bz2) \
	  $(use_enable introspection) \
	  $(use_with gtk gdk-pixbuf)
}


# vim: filetype=ebuild
