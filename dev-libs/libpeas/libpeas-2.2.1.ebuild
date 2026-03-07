# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-single-r1 flag-o-matic vala

DESCRIPTION="A GObject plugins library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libpeas"
SRC_URI="https://download.gnome.org/sources/libpeas/2.2/libpeas-2.2.1.tar.xz -> libpeas-2.2.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="glade +gtk lua +python vala"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/gobject-introspection:=
	gtk? ( x11-libs/gtk+:3[introspection] )
	lua? (
	  dev-lua/lgi
	  =dev-lang/lua-5.1*:0
	)
	python? (
	  ${PYTHON_DEPS}
	  $(python_gen_cond_dep '
	    dev-python/pygobject:3[${PYTHON_USEDEP}]
	  ')
	)
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_prepare() {
	sed -i "s@subdir('introspection')@generate_gir ? subdir('introspection') :@" tests/libpeas/meson.build
	gnome3_src_prepare
	use vala && vala_src_prepare
}
src_configure() {
	# Fix mozjs stuff
	#append-cflags -DXP_LINUX -D__linux__
	#append-cxxflags -DXP_LINUX -D__linux__
	 local emesonargs=(
	  -Dintrospection=true
	  -Dgtk_doc=false
	  -Dgjs=false
	  $(meson_use lua lua51)
	  #$(meson_use gjs)
	  $(meson_use python python3)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}


# vim: filetype=ebuild
