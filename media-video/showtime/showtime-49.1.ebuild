# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 python-single-r1 meson

DESCRIPTION="Gnome Video Player"
HOMEPAGE="https://gitlab.gnome.org/GNOME/showtime"
SRC_URI="https://download.gnome.org/sources/showtime/49/showtime-49.1.tar.xz -> showtime-49.1.tar.xz"
LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	
"
RDEPEND=">=dev-lang/python-3.10
	x11-libs/gtk:4[introspection]
	x11-libs/libadwaita
	$(python_gen_cond_dep '
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-single-r1_pkg_setup
}
src_install() {
	meson_src_install
	# fix shebang (python_fix_shebang doesn't work correctly for this).
	sed -i -e '1s:#!.*:#!/usr/bin/python:g' "${ED}"/usr/bin/showtime
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
