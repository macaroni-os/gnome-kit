# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson vala

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gtksourceview"
SRC_URI="https://download.gnome.org/sources/gtksourceview/5.18/gtksourceview-5.18.0.tar.xz -> gtksourceview-5.18.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS="*"
IUSE="gtk-doc +introspection sysprof +vala"
REQUIRED_USE="gtk-doc? ( introspection )
vala? ( introspection )
"
BDEPEND="gtk-doc? ( dev-util/gi-docgen )
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4[introspection?]
	dev-libs/libxml2:=
	introspection? ( dev-libs/gobject-introspection:= )
	dev-libs/fribidi
	media-libs/fontconfig
	x11-libs/pango[introspection?]
	dev-libs/libpcre2:=
	sysprof? ( dev-util/sysprof )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dinstall-tests=false
	  $(meson_feature introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc documentation)
	  $(meson_use sysprof)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc ; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/${PN}${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}


# vim: filetype=ebuild
