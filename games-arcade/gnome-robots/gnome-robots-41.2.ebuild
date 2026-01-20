# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit gnome3 meson cargo

DESCRIPTION="Avoid the robots and make them crash into each other"
HOMEPAGE="https://wiki.gnome.org/Apps/Robots"
SRC_URI="
https://download.gnome.org/sources/gnome-robots/41/gnome-robots-41.2.tar.xz -> gnome-robots-41.2.tar.xz
mirror://macaroni/gnome-robots-41.2-mark-rust-bundle.tar.xz -> gnome-robots-41.2-mark-rust-bundle.tar.xz"
LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libgee:=
	dev-libs/glib:2
	dev-libs/libgnome-games-support:1=
	media-libs/gsound
	x11-libs/gtk+:3
	gnome-base/librsvg
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	gnome3_src_prepare
}
src_configure() {
	cargo_src_configure
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}
src_install() {
	cargo_src_install
	meson_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
