# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="https://apps.gnome.org/Calculator/"
SRC_URI="https://download.gnome.org/sources/gnome-calculator/49/gnome-calculator-49.2.tar.xz -> gnome-calculator-49.2.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="dev-libs/appstream-glib
	dev-util/blueprint-compiler
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	net-libs/libsoup:3[vala]
	dev-libs/libgee
	dev-libs/mpc:=
	dev-libs/mpfr:=
	x11-libs/gtk:4
	x11-libs/libadwaita[vala]
	x11-libs/gtksourceview:5[vala]
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Ddisable-ui=false
	  -Dui-tests=false
	  -Dgcalc=true
	  -Dgci=true
	  -Dapp=true
	  -Ddoc=false
	  $(meson_use !introspection disable-introspection)
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
