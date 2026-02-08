# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Default file manager for the GNOME desktop"
HOMEPAGE="https://apps.gnome.org/Nautilus/"
SRC_URI="https://download.gnome.org/sources/nautilus/49/nautilus-49.4.tar.xz -> nautilus-49.4.tar.xz"
LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+cloudproviders doc gnome +gstreamer +introspection +previewer"
REQUIRED_USE="doc? ( introspection )"
# Commons depends
CDEPEND="dev-libs/glib:2
	media-libs/gexiv2
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	app-arch/gnome-autoar
	gnome-base/gnome-desktop
	gnome-base/gsettings-desktop-schemas
	x11-libs/gtk:4[X,introspection?,wayland]
	x11-libs/libadwaita
	dev-libs/libportal:=[gtk]
	x11-libs/pango
	app-misc/tinysparql
	cloudproviders? ( net-libs/libcloudproviders )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
BDEPEND="dev-util/gdbus-codegen
	doc? (
	  app-text/docbook-xml-dtd:4.1.2
	  dev-util/gi-docgen
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	app-misc/localsearch:=
	
"
DEPEND="${CDEPEND}
"
PDEPEND="gnome? ( x11-themes/adwaita-icon-theme )
	previewer? ( gnome-extra/sushi )
	gnome-base/gvfs[gtk(+)]
	
"
src_prepare() {
	default
	xdg_environment_reset
	# Disable -Werror
	sed -e '/-Werror=/d' -i meson.build ||  die
}
src_configure() {
	local emesonargs=(
	  -Dextensions=true # image file properties, also required for -Dgstreamer=true
	  -Dpackagekit=false
	  -Dselinux=false
	  -Dtests=none
	  $(meson_use cloudproviders)
	  $(meson_use doc docs)
	  $(meson_use introspection)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
