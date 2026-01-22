# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-single-r1 vala

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="https://gedit-text-editor.org/"
SRC_URI="https://download.gnome.org/sources/gedit/48/gedit-48.1.tar.xz -> gedit-48.1.tar.xz"
LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="+python gtk-doc"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
"
# Commons depends
CDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/libgedit-amtk:=
	dev-libs/libgedit-tepl
	dev-libs/libgedit-gtksourceview
	dev-libs/libpeas[gtk]
	dev-libs/gobject-introspection:=
	app-text/gspell:=
	python? (
	  ${PYTHON_DEPS}
	  $(python_gen_cond_dep '
	    dev-python/pycairo[${PYTHON_USEDEP}]
	    dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	    dev-libs/libpeas:0[python,${PYTHON_SINGLE_USEDEP}]
	  ')
	)
	
"
BDEPEND="$(vala_depend)
	gtk-doc? ( dev-util/gtk-doc )
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	x11-themes/adwaita-icon-theme
	gnome-base/gsettings-desktop-schemas
	gnome-base/gvfs
	
"
DEPEND="${CDEPEND}
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_prepare() {
	default
	vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk-doc gtk_doc)
	  -Duser_documentation=true
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use python; then
	  python_optimize
	  python_optimize "${ED}/usr/$(get_libdir)/gedit/plugins/"
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
