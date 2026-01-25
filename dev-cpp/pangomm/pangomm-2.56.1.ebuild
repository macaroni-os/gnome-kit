# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="C++ interface for pango"
HOMEPAGE="https://gtkmm.gnome.org/en/index.html"
SRC_URI="https://download.gnome.org/sources/pangomm/2.56/pangomm-2.56.1.tar.xz -> pangomm-2.56.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2.48"
KEYWORDS="*"
IUSE="gtk-doc"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  dev-cpp/mm-common
	  app-text/doxygen[dot]
	  dev-libs/libxslt
	)
	${PYTHON_DEPS}
	
"
RDEPEND="dev-cpp/cairomm:1
	dev-cpp/glibmm:2.68
	dev-libs/libsigc++:3
	x11-libs/pango
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dmaintainer-mode=false
	  -Dbuild-documentation=$(usex gtk-doc true false)
	)
	meson_src_configure
}


# vim: filetype=ebuild
