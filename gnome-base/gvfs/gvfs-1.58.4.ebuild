# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson systemd tmpfiles

DESCRIPTION="Virtual filesystem implementation for GIO"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gvfs"
SRC_URI="https://download.gnome.org/sources/gvfs/1.58/gvfs-1.58.4.tar.xz -> gvfs-1.58.4.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="afp archive bluray cdda cdr elogind fuse google gnome-keyring
gnome-online-accounts gphoto2 onedrive +http ios nfs policykit +sftp
systemd +udev +udisks zeroconf samba +mtp wsdd
"
REQUIRED_USE="cdda? ( udev )
elogind? ( !systemd udisks )
google? ( gnome-online-accounts )
mtp? ( udev )
udisks? ( udev )
systemd? ( !elogind udisks )
"
RDEPEND="app-crypt/gcr:4=
	dev-libs/glib:2
	sys-apps/dbus
	dev-libs/libxml2:2
	afp? ( dev-libs/libgcrypt:0= )
	archive? ( app-arch/libarchive:= )
	bluray? ( media-libs/libbluray )
	fuse? ( sys-fs/fuse:3= )
	wsdd? ( net-misc/wsdd )
	gnome-keyring? ( app-crypt/libsecret )
	gnome-online-accounts? ( net-libs/gnome-online-accounts:= )
	google? (
	  dev-libs/libgdata:=[crypt,gnome-online-accounts]
	  net-libs/gnome-online-accounts:=
	)
	gphoto2? ( media-libs/libgphoto2:= )
	http? (
	  dev-libs/libxml2:=
	  net-libs/libsoup:3
	)
	ios? (
	  app-pda/libimobiledevice:=
	  app-pda/libplist:=
	)
	mtp? ( media-libs/libmtp:= )
	nfs? ( net-fs/libnfs )
	policykit? (
	  sys-auth/polkit
	  sys-libs/libcap
	)
	samba? ( net-fs/samba[client] )
	sftp? ( net-misc/openssh )
	systemd? ( sys-apps/systemd:0= )
	elogind? ( sys-auth/elogind:0= )
	udev? (
	  cdda? ( dev-libs/libcdio-paranoia )
	  virtual/libgudev:=
	)
	onedrive? (
	  dev-libs/libgdata:=[crypt,gnome-online-accounts]
	  net-libs/msgraph
	)
	udisks? ( sys-fs/udisks:2 )
	zeroconf? ( net-dns/avahi )
	
"
DEPEND="app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	dev-util/gtk-doc-am
	
"
src_prepare() {
	sed -i -e '/policy,/d' daemon/meson.build
	gnome3_src_prepare
}
src_configure() {
	local enable_logind="false"
	if use systemd || use elogind; then
	  enable_logind="true"
	fi
	local enable_gcrypt="false"
	if use afp; then
	  enable_gcrypt="true"
	fi
	local enable_libusb="false"
	if use mtp; then
	  enable_libusb="true"
	fi
	local emesonargs=(
	  -Dsystemduserunitdir="$(usex systemd $(systemd_get_userunitdir) no)"
	  -Dtmpfilesdir="${EPREFIX}"/usr/lib/tmpfiles.d
	  $(meson_use policykit admin)
	  $(meson_use ios afc)
	  $(meson_use afp)
	  $(meson_use archive)
	  $(meson_use cdr burn)
	  $(meson_use cdda)
	  $(meson_use zeroconf dnssd)
	  $(meson_use gnome-online-accounts goa)
	  $(meson_use google)
	  $(meson_use gphoto2)
	  $(meson_use http)
	  $(meson_use mtp)
	  $(meson_use nfs)
	  $(meson_use onedrive)
	  $(meson_use sftp)
	  $(meson_use samba smb)
	  $(meson_use udisks udisks2)
	  $(meson_use bluray)
	  $(meson_use fuse)
	  $(meson_use udev gudev)
	  $(meson_use gnome-keyring keyring)
	  $(meson_use wsdd wsdd)
	  -Dgcr=true
	  -Dgcrypt=${enable_gcrypt}
	  -Ddeprecated_apis=false
	  -Dlogind=${enable_logind}
	  -Dlibusb=${enable_libusb}
	  -Ddevel_utils=false
	  -Dinstalled_tests=false
	  -Dman=true
	  -Dprivileged_group=wheel
	)
	meson_src_configure
}
src_compile() {
	meson_src_compile
}
src_install() {
	meson_src_install
}
pkg_postinst() {
	if use fuse; then
	  tmpfiles_process gvfsd-fuse-tmpfiles.conf
	fi
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
