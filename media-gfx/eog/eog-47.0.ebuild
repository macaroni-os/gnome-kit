# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="https://gitlab.gnome.org/GNOME/eog"
SRC_URI="https://download.gnome.org/sources/eog/47/eog-47.0.tar.xz -> eog-47.0.tar.xz"
LICENSE="GPL-2+"
SLOT="1"
KEYWORDS="*"
IUSE="+exif gtk-doc +introspection +jpeg lcms +svg xmp tiff"
REQUIRED_USE="exif? ( jpeg )
gtk-doc? ( introspection )
"
BDEPEND="gtk-doc? (
	  dev-util/gi-docgen
	  app-text/docbook-xml-dtd:4.1.2
	)
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libpeas[gtk]
	gnome-base/gnome-desktop
	gnome-base/gsettings-desktop-schemas
	x11-misc/shared-mime-info
	x11-libs/gdk-pixbuf[jpeg?,tiff?]
	x11-libs/gtk+:3[introspection,X]
	dev-libs/libhandy
	sys-libs/zlib
	exif? ( media-libs/libexif )
	lcms? ( media-libs/lcms )
	xmp? ( media-libs/exempi:= )
	jpeg? ( media-libs/libjpeg-turbo:= )
	introspection? ( dev-libs/gobject-introspection:= )
	svg? ( gnome-base/librsvg )
	x11-libs/libX11
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  $(meson_use exif libexif)
	  $(meson_use lcms cms)
	  $(meson_use xmp)
	  $(meson_use jpeg libjpeg)
	  $(meson_use svg librsvg)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  -Dinstalled_tests=false
	  -Dlibportal=false # As of 40.3, all libportal usages are flatpak-specific
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
