# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="Playlist parsing library"
HOMEPAGE="https://developer.gnome.org/totem-pl-parser/stable/"
SRC_URI="https://download.gnome.org/sources/totem-pl-parser/3.26/totem-pl-parser-3.26.7.tar.xz -> totem-pl-parser-3.26.7.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="archive crypt gtk-doc +introspection +uchardet"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	archive? ( app-arch/libarchive:= )
	dev-libs/libxml2:=
	crypt? ( dev-libs/libgcrypt:= )
	uchardet? ( app-i18n/uchardet )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	# Disable tests requiring network access, bug #346127
	# 3rd test fails on upgrade, not once installed
	sed -e 's:\(g_test_add_func.*/parser/resolution.*\):/*\1*/:' \
	  -e 's:\(g_test_add_func.*/parser/parsing/itms_link.*\):/*\1*/:' \
	  -e 's:\(g_test_add_func.*/parser/parsability.*\):/*\1/:'\
	  -i plparse/tests/parser.c || die "sed failed"
}
src_configure() {
	local emesonargs=(
	  -Denable-libarchive=$(usex archive)
	  -Denable-libgcrypt=$(usex crypt)
	  -Denable-uchardet=$(usex uchardet)
	  $(meson_use gtk-doc enable-gtk-doc)
	  $(meson_use introspection)
	)
	meson_src_configure
}


# vim: filetype=ebuild
