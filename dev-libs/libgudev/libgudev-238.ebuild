# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="GObject bindings for libudev"
HOMEPAGE="https://wiki.gnome.org/Projects/libgudev"
SRC_URI="https://download.gnome.org/sources/libgudev/238/libgudev-238.tar.xz -> libgudev-238.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="introspection"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	virtual/udev
	introspection? ( dev-libs/gobject-introspection )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_feature introspection)
	  -Dgtk_doc=false
	  -Dtests=disabled
	  -Dvapi=disabled
	)
	meson_src_configure
}


# vim: filetype=ebuild
