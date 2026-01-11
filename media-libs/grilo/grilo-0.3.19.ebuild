# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 vala gnome3

DESCRIPTION="A framework for easy media discovery and browsing"
HOMEPAGE="https://gitlab.gnome.org/GNOME/grilo"
SRC_URI="https://download.gnome.org/sources/grilo/0.3/grilo-0.3.19.tar.xz -> grilo-0.3.19.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0.3/0"
KEYWORDS="*"
IUSE="gtk gtk-doc +introspection +network +playlist vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	${PYTHON_DEPS}
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	net-libs/libsoup:3
	network? ( dev-libs/libxml2:2 )
	playlist? ( dev-libs/totem-pl-parser:= )
	introspection? ( dev-libs/gobject-introspection:= )
	gtk? (
	  net-libs/liboauth
	  x11-libs/gtk+:3
	)
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	sed -i -e "s:'GETTEXT_PACKAGE', meson.project_name():'GETTEXT_PACKAGE', 'grilo-${SLOT%/*}':" meson.build || die
	sed -i -e "s:meson.project_name():'grilo-${SLOT%/*}':" po/meson.build || die
	sed -i -e "s:'grilo':'grilo-${SLOT%/*}':" doc/grilo/meson.build || die
	# Drop explicit unversioned vapigen check
	sed -i -e "/find_program.*vapigen/d" meson.build || die
	# Don't build examples; they get embedded in gtk-doc, thus we don't install the sources with USE=examples either
	sed -i -e "/subdir('examples')/d" meson.build || die
	gnome3_src_prepare
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  $(meson_use network enable-grl-net)
	  $(meson_use playlist enable-grl-pls)
	  $(meson_use gtk-doc enable-gtk-doc)
	  $(meson_use introspection enable-introspection)
	  $(meson_use gtk enable-test-ui)
	  $(meson_use vala enable-vala)
	)
	meson_src_configure
}


# vim: filetype=ebuild
