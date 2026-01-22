# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg gnome3

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glib-networking"
SRC_URI="https://download.gnome.org/sources/glib-networking/2.80/glib-networking-2.80.1.tar.xz -> glib-networking-2.80.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+gnome +libproxy +ssl"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	libproxy? ( net-libs/libproxy )
	net-libs/gnutls:=
	ssl? ( app-misc/ca-certificates )
	gnome? ( gnome-base/gsettings-desktop-schemas )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dgnutls=enabled
	  -Dopenssl=$(usex ssl enabled disabled)
	  $(meson_feature libproxy)
	  $(meson_feature gnome gnome_proxy)
	  -Dinstalled_tests=false
	  -Ddebug_logs=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
	gnome3_giomodule_cache_update || die "Update GIO modules cache failed (for ${ABI})"
}
pkg_postrm() {
	gnome3_pkg_postrm
	gnome3_giomodule_cache_update || die "Update GIO modules cache failed (for ${ABI})"
}


# vim: filetype=ebuild
