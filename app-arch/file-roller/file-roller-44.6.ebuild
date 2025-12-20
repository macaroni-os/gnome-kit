# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Archive manager for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/file-roller"
SRC_URI="https://download.gnome.org/sources/file-roller/44/file-roller-44.6.tar.xz -> file-roller-44.6.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection nautilus"
REQUIRED_USE="gtk-doc? ( introspection )"
BDEPEND="dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4[introspection?]
	x11-libs/libadwaita
	nautilus? ( gnome-base/nautilus )
	dev-libs/json-glib
	app-arch/libarchive:=
	introspection? ( dev-libs/gobject-introspection:= )
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	cp -v "${FILESDIR}"/44.4-packages.match data/packages.match || die
	default
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Drun-in-place=false
	  $(meson_feature nautilus nautilus-actions)
	  -Dnotification=enabled
	  -Duse_native_appchooser=false
	  -Dpackagekit=false
	  -Dlibarchive=enabled
	  $(meson_feature introspection)
	  $(meson_feature gtk-doc api_docs)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/ || die
	  mv "${ED}"/usr/share/doc/file-roller "${ED}"/usr/share/gtk-doc/file-roller || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
