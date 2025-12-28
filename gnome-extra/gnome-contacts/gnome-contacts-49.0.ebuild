# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1 vala

DESCRIPTION="GNOME contact management application"
HOMEPAGE="https://apps.gnome.org/Contacts/"
SRC_URI="https://download.gnome.org/sources/gnome-contacts/49/gnome-contacts-49.0.tar.xz -> gnome-contacts-49.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+gnome-online-accounts"
BDEPEND="${PYTHON_DEPS}
	dev-util/blueprint-compiler
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxml2
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/folks:=[eds]
	dev-libs/libgee:=
	dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	gnome-extra/evolution-data-server:=[gnome-online-accounts?,vala]
	dev-libs/libportal:=[gtk,vala]
	media-libs/gstreamer
	media-gfx/qrencode:=
	gnome-online-accounts? ( net-libs/gnome-online-accounts:=[vala] )
	dev-libs/gobject-introspection:=
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dcamera=true
	  -Dmanpage=true
	  -Ddocs=false
	  $(meson_use gnome-online-accounts goa)
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
