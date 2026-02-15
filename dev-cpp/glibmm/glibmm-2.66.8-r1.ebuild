# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION=""
SRC_URI="https://download.gnome.org/sources/glibmm/2.66/glibmm-2.66.8.tar.xz -> glibmm-2.66.8.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="gtk-doc debug"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	gtk-doc? (
	  app-doc/doxygen
	  dev-lang/perl
	  dev-libs/libxslt
	)
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libsigc++
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dwarnings=min
	  -Dbuild-deprecated-api=true
	  -Dbuild-documentation=$(usex gtk-doc true false)
	  $(meson_use debug debug-refcounting)
	  -Dbuild-examples=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
