# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="https://apps.gnome.org/en/DiskUtility/"
SRC_URI="https://download.gnome.org/sources/gnome-disk-utility/46/gnome-disk-utility-46.1.tar.xz -> gnome-disk-utility-46.1.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="fat elogind gnome systemd"
REQUIRED_USE="?? ( elogind systemd )"
# Commons depends
CDEPEND="media-libs/libdvdread:=
	dev-libs/glib:2
	x11-libs/gtk+:3
	media-libs/libcanberra[gtk3]
	dev-libs/libhandy
	app-arch/xz-utils
	app-crypt/libsecret
	dev-libs/libpwquality
	sys-fs/udisks
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd:= )
	
"
BDEPEND="dev-libs/libxml2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	x11-themes/adwaita-icon-theme
	fat? ( sys-fs/dosfstools )
	gnome? ( gnome-base/gnome-settings-daemon )
	
"
DEPEND="${CDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dlogind=$(usex systemd libsystemd $(usex elogind libelogind none))
	  $(meson_use gnome gsd_plugin)
	  -Dman=true
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
