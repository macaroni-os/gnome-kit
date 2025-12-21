# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit fcaps meson gnome3 pam

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-keyring"
SRC_URI="https://download.gnome.org/sources/gnome-keyring/48/gnome-keyring-48.0.tar.xz -> gnome-keyring-48.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gnome-keyring-48.0-collection-registering.patch"
	"${FILESDIR}/gnome-keyring-48.0-gkm_marshal-header.patch"
	"${FILESDIR}/gnome-keyring-48.0-disable-libcap-ng-automagic.patch"
	"${FILESDIR}/gnome-keyring-48.0-fix-pam-install.patch"
)
IUSE="caps pam ssh-agent systemd"
RDEPEND="dev-libs/glib:2
	app-crypt/gcr:=[gtk]
	dev-libs/libgcrypt:=
	app-crypt/p11-kit
	app-eselect/eselect-pinentry
	app-misc/ca-certificates
	caps? ( sys-libs/libcap-ng )
	systemd? ( sys-apps/systemd )
	ssh-agent? ( net-misc/openssh )
	
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.3
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	
"
src_configure() {
	local emesonargs=(
	  -Dselinux=disabled
	  $(meson_feature caps libcap-ng)
	  $(meson_feature systemd)
	  $(meson_use ssh-agent)
	  $(meson_use pam)
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
