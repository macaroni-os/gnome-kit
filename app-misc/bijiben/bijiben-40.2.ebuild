# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1

DESCRIPTION="Note editor designed to remain simple to use"
HOMEPAGE="https://gitlab.gnome.org/GNOME/bijiben"
SRC_URI="https://download.gnome.org/sources/bijiben/40/bijiben-40.2.tar.xz -> bijiben-40.2.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	dev-libs/appstream-glib
	dev-util/gdbus-codegen
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="app-misc/tinysparql:=
	dev-libs/glib:2
	net-libs/gnome-online-accounts:=
	x11-libs/gtk+:3
	dev-libs/json-glib
	gnome-extra/evolution-data-server:=
	dev-libs/libhandy:=
	dev-libs/libxml2
	net-misc/curl
	sys-apps/util-linux
	net-libs/webkit-gtk:4
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dupdate_mimedb=false
	  -Dprivate_store=false
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
