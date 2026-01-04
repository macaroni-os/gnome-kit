# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="Library for aggregating people from multiple sources"
HOMEPAGE="https://gitlab.gnome.org/GNOME/folks"
SRC_URI="https://download.gnome.org/sources/folks/0.15/folks-0.15.9.tar.xz -> folks-0.15.9.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="bluetooth eds utils"
REQUIRED_USE="bluetooth? ( eds )"
# Commons depends
CDEPEND="dev-libs/glib:2
	dev-libs/gobject-introspection:=
	dev-libs/libgee[introspection]
	dev-libs/libxml2
	eds? ( gnome-extra/evolution-data-server:=[vala] )
	utils? ( sys-libs/readline:= )
	
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="${CDEPEND}
	bluetooth? ( net-wireless/bluez[obex] )
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  $(meson_use bluetooth bluez_backend)
	  $(meson_use eds eds_backend)
	  $(meson_use eds ofono_backend)
	  $(meson_use utils inspect_tool)
	  -Dtelepathy_backend=false # obsolete dependency
	  -Dzeitgeist=false
	  -Dimport_tool=true
	  -Dtests=false
	  -Dinstalled_tests=false
	  -Ddocs=false
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
