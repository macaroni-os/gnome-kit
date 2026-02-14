# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="C++ interface for the ATK library"
HOMEPAGE="https://gtkmm.gnome.org/en/index.html"
SRC_URI="https://download.gnome.org/sources/atkmm/2.36/atkmm-2.36.3.tar.xz -> atkmm-2.36.3.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2.36"
KEYWORDS="*"
IUSE="gtk-doc"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  dev-cpp/mm-common
	  app-doc/doxygen[dot]
	  dev-libs/libxslt
	)
	${PYTHON_DEPS}
	
"
RDEPEND="dev-cpp/glibmm:2.68[gtk-doc?]
	>=dev-libs/atk-2.58.0
	dev-libs/libsigc++
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dbuild-documentation=$(usex gtk-doc true false)
	)
	meson_src_configure
}


# vim: filetype=ebuild
