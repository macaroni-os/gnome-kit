# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-single-r1

DESCRIPTION="Legacy Media player for GNOME"
HOMEPAGE="https://apps.gnome.org/Totem/"
SRC_URI="https://download.gnome.org/sources/totem/43/totem-43.2.tar.xz -> totem-43.2.tar.xz"
LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
"
# Commons depends
CDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/libhandy
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0[pango]
	media-libs/gst-plugins-good:1.0
	media-libs/grilo[playlist]
	dev-libs/libpeas[gtk]
	dev-libs/totem-pl-parser:=[introspection]
	gnome-base/gnome-desktop:=
	gnome-base/gsettings-desktop-schemas
	media-libs/libepoxy
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	dev-libs/gobject-introspection:=
	python? (
	  ${PYTHON_DEPS}
	  $(python_gen_cond_dep '
	    dev-python/pygobject:3[${PYTHON_USEDEP}]
	  ')
	)
	
"
BDEPEND="dev-lang/perl
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.5
	)
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	media-plugins/grilo-plugins
	x11-themes/adwaita-icon-theme
	dev-libs/libportal:=[gtk]
	python? (
	  x11-libs/pango[introspection]
	  dev-libs/libpeas[python,${PYTHON_SINGLE_USEDEP}]
	  $(python_gen_cond_dep '
	    dev-python/dbus-python[${PYTHON_USEDEP}]
	  ')
	)
	
"
DEPEND="${CDEPEND}
	x11-base/xorg-proto
	
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_prepare() {
	default
	xdg_environment_reset
	# Drop pointless samplepython plugin from build
	sed -e '/samplepython/d' -i src/plugins/meson.build || die
}
src_configure() {
	# work around sandbox violation
	for card in /dev/dri/card* ; do
	  addpredict "${card}"
	done
	addpredict /proc/self/task
	local emesonargs=(
	  -Dhelp=true
	  -Denable-easy-codec-installation=yes
	  -Denable-python=$(usex python yes no)
	  -Dlibportal=enabled
	  -Dwith-plugins=all
	  -Dui-tests=false
	  $(meson_use gtk-doc enable-gtk-doc)
	  -Dprofile=default
	  -Dinspector-page=false
	)
	meson_src_configure
}
src_install() {
	local -x GST_PLUGIN_SYSTEM_PATH_1_0= # bug 812170
	meson_src_install
	if use python ; then
	  python_optimize "${ED}"/usr/$(get_libdir)/totem/plugins/
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
