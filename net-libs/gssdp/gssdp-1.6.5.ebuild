# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala xdg

DESCRIPTION="GObject-based API for handling resource discovery and announcement over SSDP"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gssdp"
SRC_URI="https://download.gnome.org/sources/gssdp/1.6/gssdp-1.6.5.tar.xz -> gssdp-1.6.5.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.6"
KEYWORDS="*"
IUSE="gtk gtk-doc +introspection man +vala"
REQUIRED_USE="gtk-doc? ( introspection )
vala? ( introspection )
"
BDEPEND="gtk-doc? (
	  dev-util/gi-docgen
	  app-text/docbook-xml-dtd:4.1.2
	)
	virtual/pkgconfig
	vala? (
	  $(vala_depend)
	)
	
"
RDEPEND="dev-libs/glib:2
	net-libs/libsoup:3
	gtk? ( x11-libs/gtk:4 )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	man? ( app-text/pandoc-bin )
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  # Never use gi-docgen subproject
	  --wrap-mode nofallback
	  -Dgtk_doc=$(usex gtk-doc true false)
	  -Dsniffer=$(usex gtk true false)
	  -Dintrospection=$(usex introspection true false)
	  -Dmanpages=$(usex man true false)
	  -Dvapi=$(usex vala true false)
	  -Dexamples=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc ; then
	  mkdir "${ED}"/usr/share/gtk-doc || die
	  mv "${ED}"/usr/share/{doc,gtk-doc}/gssdp-1.6 || die
	fi
}


# vim: filetype=ebuild
