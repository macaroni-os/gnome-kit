# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="C++ interface for GTK+"
HOMEPAGE="https://gtkmm.gnome.org/en/index.html"
SRC_URI="https://download.gnome.org/sources/gtkmm/3.24/gtkmm-3.24.10.tar.xz -> gtkmm-3.24.10.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="3.0"
KEYWORDS="*"
IUSE="gtk-doc wayland X"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  app-text/doxygen[dot]
	  dev-lang/perl
	  dev-libs/libxslt
	)
	${PYTHON_DEPS}
	
"
RDEPEND="dev-cpp/atkmm:0
	dev-cpp/glibmm:2
	x11-libs/gtk+:3[wayland?,X=]
	dev-cpp/cairomm:1
	dev-cpp/pangomm:1.4
	x11-libs/gdk-pixbuf
	media-libs/libepoxy
	
"
DEPEND="${RDEPEND}
	
"
src_configure() {
	local emesonargs=(
	  -Dbuild-demos=false
	  -Dbuild-tests=false
	  -Dbuild-documentation=$(usex gtk-doc true false)
	  -Dbuild-x11-api=$(usex X true false)
	)
	meson_src_configure
}


# vim: filetype=ebuild
