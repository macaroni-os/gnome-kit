# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1 vala

DESCRIPTION="Location and timezone database and weather-lookup library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgweather"
SRC_URI="https://download.gnome.org/sources/libgweather/4.4/libgweather-4.4.4.tar.xz -> libgweather-4.4.4.tar.xz"
LICENSE="GPL-2+"
SLOT="4"
KEYWORDS="*"
IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )
gtk-doc? ( introspection )
"
BDEPEND="gtk-doc? ( dev-util/gi-docgen )
	sys-devel/gettext
	virtual/pkgconfig
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	net-libs/libsoup:3
	sci-geosciences/geocode-glib
	dev-libs/libxml2:2
	dev-libs/json-glib
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_prepare() {
	default
	gnome3_environment_reset
	use vala && vala_src_prepare
	sed -i -e '/metar/d' libgweather/tests/meson.build || die
}
src_configure() {
	local emesonargs=(
	  $(meson_use vala enable_vala)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  -Dsoup2=false
	  -Dtests=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/ || die
	  mv "${ED}"/usr/share/doc/libgweather-4.0 "${ED}"/usr/share/gtk-doc/ || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
