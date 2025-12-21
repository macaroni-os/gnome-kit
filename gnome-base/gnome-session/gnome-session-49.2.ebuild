# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson systemd

DESCRIPTION="Gnome session manager"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-session"
SRC_URI="https://download.gnome.org/sources/gnome-session/49/gnome-session-49.2.tar.xz -> gnome-session-49.2.tar.xz"
LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gnome-session-49-elogind.patch"
)
IUSE="doc elogind systemd X"
REQUIRED_USE="^^ ( elogind systemd )
"
# Commons depends
CDEPEND="dev-libs/glib:2
	X? (
	  x11-libs/gtk:4
	  x11-libs/libICE
	  x11-libs/libSM
	  x11-libs/libX11
	)
	gnome-base/gnome-desktop
	dev-libs/json-glib
	media-libs/libglvnd[X]
	media-libs/libepoxy
	x11-libs/libXcomposite
	systemd? ( sys-apps/systemd:= )
	elogind? ( sys-auth/elogind:= )
	
"
BDEPEND="dev-libs/libxslt
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
	  app-text/xmlto
	  app-text/docbook-xml-dtd:4.1.2
	)
	
"
RDEPEND="${CDEPEND}
	gnome-base/gnome-settings-daemon
	gnome-base/gsettings-desktop-schemas
	sys-apps/dbus[elogind=,systemd=,X]
	x11-misc/xdg-user-dirs
	x11-misc/xdg-user-dirs-gtk
	
"
DEPEND="${CDEPEND}
	x11-libs/xtrans
	
"
src_prepare() {
	default
	gnome3_environment_reset
	# Install USE=doc in ${PF} if enabled
	#sed -i -e "s:meson\.project_name(), 'dbus':'${PF}', 'dbus':" doc/dbus/meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Ddeprecation_flags=false
	  -Dman=true
	  -Dsystemduserunitdir="$(systemd_get_userunitdir)"
	  $(meson_use doc docbook)
	  $(meson_use X x11)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/Gnome"
	newmenu "${FILESDIR}/defaults.list-r7" gnome-mimeapps.list
	exeinto /etc/X11/xinit/xinitrc.d/
	newexe "${FILESDIR}/15-xdg-data-gnome-r1" 15-xdg-data-gnome
	# This should be done here as discussed in bug #270852
	newexe "${FILESDIR}/10-user-dirs-update-gnome-r1" 10-user-dirs-update-gnome
	# Set XCURSOR_THEME from current dconf setting instead of installing
	# default cursor symlink globally and affecting other DEs (bug #543488)
	# https://bugzilla.gnome.org/show_bug.cgi?id=711703
	newexe "${FILESDIR}/90-xcursor-theme-gnome" 90-xcursor-theme-gnome
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
