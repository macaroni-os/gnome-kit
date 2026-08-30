# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools gnome3

DESCRIPTION="Compiler for the GObject type system"
HOMEPAGE="https://wiki.gnome.org/Projects/Vala"
SRC_URI="https://download.gnome.org/sources/vala/0.56/vala-0.56.19.tar.xz -> vala-0.56.19.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0.56"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	virtual/yacc
	
"
RDEPEND="dev-libs/glib
	>=dev-libs/vala-common-0.56.19
	media-gfx/graphviz
	dev-libs/gobject-introspection:=
	
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	sys-devel/flex
	
"
S="${WORKDIR}/vala-0.56.19"
src_configure() {
	  # weasyprint enables generation of PDF from HTML
	  gnome3_src_configure \
	      --disable-unversioned \
	      VALAC=: \
	      WEASYPRINT=:
}
src_install() {
	  default
	  find "${D}" -name "*.la" -delete || die
}


# vim: filetype=ebuild
