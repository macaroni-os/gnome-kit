# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Personal task manager"
SRC_URI="https://gitlab.gnome.org/World/Endeavour/-/archive/43.0/Endeavour-43.0.tar.bz2 -> endeavour-43.0.tar.bz2"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="dev-libs/libxml2
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4[introspection?]
	x11-libs/libadwaita
	net-libs/gnome-online-accounts:=
	dev-libs/libpeas
	gnome-extra/evolution-data-server:=[gtk]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/Endeavour-43.0"
src_configure() {
	local emesonargs=(
	  $(meson_use introspection)
	  -Dtracing=false
	  -Dprofile=default
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
