# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic gnome3 meson python-any-r1 vala

DESCRIPTION="Unicode character map viewer and library"
HOMEPAGE="https://wiki.gnome.org/Apps/Gucharmap"
SRC_URI="https://download.gnome.org/sources/gucharmap/17.0/gucharmap-17.0.2.tar.xz -> gucharmap-17.0.2.tar.xz"
LICENSE="GPL-3+"
SLOT="2.90"
KEYWORDS="*"
IUSE="+introspection gtk-doc vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="${PYTHON_DEPS}
	app-text/docbook-xml-dtd:4.1.2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection:= )
	vala? ( $(vala_depend) )
	
"
RDEPEND="media-libs/freetype:2
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	dev-libs/libpcre2:=
	app-i18n/unicode-data
	x11-libs/pango[introspection]
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	# Upstream don't support LTO
	filter-lto
	local emesonargs=(
	  -Dcharmap=true
	  -Ddbg=false
	  -Dgtk3=true
	  -Ducd_path="${EPREFIX}/usr/share/unicode-data"
	  $(meson_use gtk-doc docs)
	  $(meson_use introspection gir)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
