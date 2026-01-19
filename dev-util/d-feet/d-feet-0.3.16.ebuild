# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-single-r1

DESCRIPTION="Feet is a powerful D-Bus debugger"
HOMEPAGE="https://gitlab.gnome.org/GNOME/d-feet"
SRC_URI="https://download.gnome.org/sources/d-feet/0.3/d-feet-0.3.16.tar.xz -> d-feet-0.3.16.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# Commons depends
CDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/gobject-introspection:=
	
"
BDEPEND="virtual/pkgconfig
	dev-util/itstool
	
"
RDEPEND="${CDEPEND}
	$(python_gen_cond_dep '
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	sys-apps/dbus
	X? ( x11-libs/libwnck:3[introspection] )
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	sed -i -e "/desktop,/d" -e "/appdata,/d" data/meson.build
	gnome3_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dtests=false
	  -Dpython="${EPYTHON}"
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_optimize
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
