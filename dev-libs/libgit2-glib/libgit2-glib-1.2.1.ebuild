# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-r1 vala

DESCRIPTION="Git library for GLib"
HOMEPAGE="https://wiki.gnome.org/Projects/Libgit2-glib"
SRC_URI="https://download.gnome.org/sources/libgit2-glib/1.2/libgit2-glib-1.2.1.tar.xz -> libgit2-glib-1.2.1.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc python +ssh +vala"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
BDEPEND="virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/gobject-introspection:=
	dev-libs/glib:2
	dev-libs/libgit2:=[ssh?]
	python? (
	  ${PYTHON_DEPS}
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	)
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	sed -i -e '/meson_python_compile.py/d' meson.build || die
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dintrospection=true
	  -Dpython=false # we install python scripts manually
	  $(meson_use ssh)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use python ; then
	  python_moduleinto gi.overrides
	  python_foreach_impl python_domodule libgit2-glib/Ggit.py
	fi
}


# vim: filetype=ebuild
