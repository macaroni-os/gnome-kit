# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1

DESCRIPTION="Eye of GNOME plugins"
HOMEPAGE="https://gitlab.gnome.org/GNOME/eog-plugins"
SRC_URI="https://download.gnome.org/sources/eog-plugins/44/eog-plugins-44.1.tar.xz -> eog-plugins-44.1.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="+exif map +python"
REQUIRED_USE="map? ( exif )
python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libpeas
	media-gfx/eog
	exif? ( media-libs/libexif )
	map? (
	  media-libs/libchamplain[gtk]
	  media-libs/clutter
	  media-libs/clutter-gtk
	)
	python? (
	  ${PYTHON_DEPS}
	  dev-libs/glib[dbus]
	  dev-libs/libpeas[gtk,python,${PYTHON_SINGLE_USEDEP}]
	  $(python_gen_cond_dep '
	    dev-python/pygobject:3[${PYTHON_USEDEP}]
	  ')
	  gnome-base/gsettings-desktop-schemas
	  media-gfx/eog[introspection]
	  x11-libs/gtk+:3[introspection]
	  x11-libs/pango[introspection]
	)
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_configure() {
	local emesonargs=(
	  -Dplugin_fit-to-width=true
	  -Dplugin_light-theme=true
	  -Dplugin_postasa=false
	  -Dplugin_postr=false
	  -Dplugin_send-by-mail=true
	  $(meson_use python plugin_fullscreenbg)
	  $(meson_use exif plugin_exif-display)
	  $(meson_use map plugin_map)
	  $(meson_use python plugin_export-to-folder)
	  $(meson_use python plugin_maximize-windows)
	  $(meson_use python plugin_pythonconsole)
	  $(meson_use python plugin_slideshowshuffle)
	)
	meson_src_configure
}


# vim: filetype=ebuild
