# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="Build infrastructure and utilities for GNOME C++ bindings"
HOMEPAGE="https://gtkmm.gnome.org/en/index.html"
SRC_URI="https://download.gnome.org/sources/mm-common/1.0/mm-common-1.0.8.tar.xz -> mm-common-1.0.8.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	
"
src_prepare() {
	default
	# Include project version in docdir name
	sed -i -e "s:^install_docdir.*:& + '-' + meson.project_version():" meson.build || die
}


# vim: filetype=ebuild
