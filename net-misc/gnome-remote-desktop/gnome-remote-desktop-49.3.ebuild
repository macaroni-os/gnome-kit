# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson systemd tmpfiles

DESCRIPTION=""
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-remote-desktop"
SRC_URI="https://download.gnome.org/sources/gnome-remote-desktop/49/gnome-remote-desktop-49.3.tar.xz -> gnome-remote-desktop-49.3.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="doc +rdp systemd +vnc"
REQUIRED_USE="|| ( rdp vnc )"
BDEPEND="dev-util/gdbus-codegen
	virtual/pkgconfig
	doc? (
	  app-text/asciidoc
	)
	
"
RDEPEND="x11-libs/cairo
	x11-libs/libdrm
	media-libs/libepoxy
	dev-libs/glib:2
	dev-libs/libei
	x11-libs/libnotify
	app-crypt/libsecret
	media-video/pipewire:=
	app-crypt/tpm2-tss:=
	rdp? (
	  media-libs/nv-codec-headers
	  net-misc/freerdp:=[server]
	  sys-fs/fuse:3=
	  media-libs/libva
	  sys-auth/polkit
	  media-libs/shaderc
	  dev-uti/spirv-tools
	  x11-libs/libxkbcommon
	  media-libs/fdk-acc:=
	)
	vnc? (
	  net-libs/libvncserver
	)
	x11-wm/mutter[screencast]
	
"
DEPEND="${RDEPEND}
	rdp? (
	  dev-util/vulkan-headers
	)
	
"
src_configure() {
	local emesonargs=(
	  $(meson_use doc man)
	  $(meson_use rdp)
	  $(meson_use vnc)
	  $(meson_use systemd)
	  -Dsystemd_user_unit_dir="$(systemd_get_userunitdir)"
	  -Dtests=false  # Tests run xvfb-run directly
	)
	meson_src_configure
}
pkg_postinst() {
	tmpfiles_process "${PN}-tmpfiles.conf"
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
