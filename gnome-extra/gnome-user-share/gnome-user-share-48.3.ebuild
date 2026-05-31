# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit cargo gnome3 meson systemd

DESCRIPTION="Personal file sharing for the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-user-share"
SRC_URI="
https://download.gnome.org/sources/gnome-user-share/48/gnome-user-share-48.3.tar.xz -> gnome-user-share-48.3.tar.xz
mirror://macaroni/gnome-user-share-48.3-mark-rust-bundle.tar.xz -> gnome-user-share-48.3-mark-rust-bundle.tar.xz"
LICENSE="GPL-2 Apache-2.0 Apache-2.0-with-LLVM-exceptions
BSD ISC MIT Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	www-apache/mod_dnssd
	www-servers/apache[apache2_modules_dav,apache2_modules_dav_fs,apache2_modules_authn_file,apache2_modules_auth_digest,apache2_modules_authz_groupfile]
	
"
DEPEND="${RDEPEND}
"
src_unpack() {
	cargo_src_unpack
}
src_prepare() {
	default
	# disable prefork
	sed -i -e '/^LoadModule mpm_prefork_module/d' data/dav_user_2.4.conf || die
}
src_configure() {
	local emesonargs=(
	  -Dsystemduserunitdir="$(systemd_get_userunitdir)"
	  -Dhttpd=apache2
	  -Dmodules_path=/usr/$(get_libdir)/apache2/modules/
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
