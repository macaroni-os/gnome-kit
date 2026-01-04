# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Gnome keyboard configuration library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgnomekbd"
SRC_URI="https://download.gnome.org/sources/libgnomekbd/3.28/libgnomekbd-3.28.1.tar.xz -> libgnomekbd-3.28.1.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[X,introspection?]
	x11-libs/libX11
	x11-libs/libxklavier:=[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_use introspection)
	  -Dvapi=false
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
