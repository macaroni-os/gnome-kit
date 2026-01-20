# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-single-r1

DESCRIPTION="Customize advanced GNOME options"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-tweaks"
SRC_URI="https://download.gnome.org/sources/gnome-tweaks/49/gnome-tweaks-49.0.tar.xz -> gnome-tweaks-49.0.tar.xz"
LICENSE="GPL-3+ CC0-1.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gnome-tweaks-py39.patch"
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# Commons depends
CDEPEND="${PYTHON_DEPS}
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	$(python_gen_cond_dep '
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	gnome-base/gnome-settings-daemon
	x11-themes/sound-theme-freedesktop
	dev-libs/glib:2
	dev-libs/gobject-introspection
	x11-libs/gtk:4[introspection]
	x11-libs/libadwaita[introspection]
	dev-libs/libgudev[introspection]
	gnome-base/gnome-desktop
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
	gnome-base/gsettings-desktop-schemas[introspection]
	gnome-base/gnome-shell
	x11-wm/mutter
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	sed -i -e 's|3.10|3.9|' meson.build
}
src_install() {
	meson_src_install
	python_optimize
	python_fix_shebang "${ED}"/usr/bin/
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
