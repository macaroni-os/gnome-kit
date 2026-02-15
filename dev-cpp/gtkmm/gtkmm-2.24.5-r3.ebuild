# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3

DESCRIPTION="C++ interface for GTK+"
HOMEPAGE="https://gtkmm.gnome.org/en/index.html"
SRC_URI="https://download.gnome.org/sources/gtkmm/2.24/gtkmm-2.24.5.tar.xz -> gtkmm-2.24.5.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2.4"
KEYWORDS="*"
IUSE="gtk-doc examples"
BDEPEND="virtual/pkgconfig
	gtk-doc? (
	  app-doc/doxygen[dot]
	  media-gfx/graphviz
	  dev-libs/libxslt
	  dev-lang/perl
	)
	
"
RDEPEND="dev-cpp/atkmm
	dev-cpp/cairomm:0
	dev-cpp/glibmm:2
	dev-cpp/pangomm
	dev-libs/libsigc++:2
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	
"
DEPEND="${RDEPEND}
	
"
src_prepare() {
	# don't waste time building tests
	sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
	  || die "sed 1 failed"
	if ! use examples; then
	  sed 's/^\(SUBDIRS =.*\)demos\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
	    || die "sed 2 failed"
	fi
	gnome3_src_prepare
}
src_configure() {
	ECONF_SOURCE="${S}" \
	gnome3_src_configure \
	  --enable-api-atkmm \
	  $(use_enable gtk-doc documentation)
}
src_install() {
	gnome3_src_install
	DOCS="AUTHORS ChangeLog PORTING NEWS README"
	einstalldocs
}


# vim: filetype=ebuild
