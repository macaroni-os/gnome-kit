# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 desktop meson pam systemd udev user

DESCRIPTION="GNOME Display Manager for managing graphical display servers and user logins"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gdm"
SRC_URI="https://download.gnome.org/sources/gdm/49/gdm-49.2.tar.xz -> gdm-49.2.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="accessibility audit bluetooth-sound elogind fprint
plymouth systemd tcpd wayland +X
"
REQUIRED_USE="^^ ( elogind systemd ) || ( wayland X )
"
# Commons depends
CDEPEND="virtual/udev
	dev-libs/libgudev:=
	dev-libs/glib:2
	dev-libs/json-glib
	sys-apps/accountsservice
	sys-apps/keyutils:=
	X? (
	  x11-libs/libxcb
	  x11-libs/libX11
	  x11-libs/libXau
	  x11-libs/libXdmcp
	  x11-base/xorg-server
	  x11-libs/gtk+:3
	)
	tcpd? ( sys-apps/tcp-wrappers )
	systemd? ( sys-apps/systemd:=[pam] )
	elogind? ( sys-auth/elogind[pam] )
	plymouth? ( sys-boot/plymouth )
	audit? ( sys-process/audit )
	sys-libs/pam
	sys-auth/pambase
	gnome-base/dconf
	gnome-base/gnome-settings-daemon
	gnome-base/gsettings-desktop-schemas
	sys-apps/dbus
	x11-misc/xdg-utils
	dev-libs/gobject-introspection:=
	
"
BDEPEND="dev-util/gdbus-codegen
	dev-util/itstool
	gnome-base/dconf
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	gnome-base/gnome-session
	gnome-base/gnome-shell
	x11-apps/xhost
	accessibility? (
	  app-accessibility/orca
	  gnome-extra/mousetweaks
	)
	fprint? ( sys-auth/fprintd[pam] )
	
"
DEPEND="${CDEPEND}
	x11-base/xorg-proto
	
"
pkg_setup() {
	enewgroup gdm
	enewgroup video # Just in case it hasn't been created yet
	enewuser gdm -1 -1 /var/lib/gdm gdm,video
	if ! egetent group video | grep -q gdm; then
	  local g=$(groups gdm)
	  elog "Adding user gdm to video group"
	  usermod -G video,${g// /,} gdm || die "Adding user gdm to video group failed"
	fi
}
src_configure() {
	local emesonargs=(
	  --localstatedir /var
	  -Ddefault-pam-config=exherbo
	  -Dgdm-xsession=true
	  -Dgroup=gdm
	  -Dipv6=true
	  $(meson_feature audit libaudit)
	  -Dlogind-provider=$(usex systemd systemd elogind)
	  -Dpam-mod-dir=$(getpam_mod_dir)
	  $(meson_feature plymouth)
	  -Drun-dir=/run/gdm
	  -Dselinux=disabled
	  $(meson_use systemd systemd-journal)
	  $(meson_use tcpd tcp-wrappers)
	  -Dudev-dir=$(get_udevdir)/rules.d
	  -Duser=gdm
	  -Duser-display-server=true
	  $(meson_use wayland wayland-support)
	  $(meson_use X x11-support)
	  $(meson_feature X xdmcp)
	)
	 if use elogind; then
	  emesonargs+=(
	    -Dinitial-vt=7
	    -Dsystemdsystemunitdir=no
	    -Dsystemduserunitdir=no
	  )
	else
	  emesonargs+=(
	    -Dinitial-vt=1
	    -Dsystemdsystemunitdir="$(systemd_get_systemunitdir)"
	    -Dsystemduserunitdir="$(systemd_get_userunitdir)"
	  )
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
	if ! use bluetooth-sound ; then
	  insinto /var/lib/gdm/.config/pulse
	  doins "${FILESDIR}"/default.pa
	fi
	# install XDG_DATA_DIRS gdm changes
	echo 'XDG_DATA_DIRS="/usr/share/gdm"' > 99xdg-gdm
	doenvd 99xdg-gdm
	# Rewrite RequireComponents on gnome-login.session. I prefer
	# keep control of the mandatory components used in bootstrap.
	local components=(
	  "org.gnome.Shell"
	  "org.gnome.SettingsDaemon.A11ySettings"
	  "org.gnome.SettingsDaemon.Color"
	  "org.gnome.SettingsDaemon.Datetime"
	  "org.gnome.SettingsDaemon.Housekeeping"
	  "org.gnome.SettingsDaemon.Keyboard"
	  "org.gnome.SettingsDaemon.MediaKeys"
	  "org.gnome.SettingsDaemon.Power"
	  "org.gnome.SettingsDaemon.PrintNotifications"
	  "org.gnome.SettingsDaemon.Rfkill"
	  "org.gnome.SettingsDaemon.ScreensaverProxy"
	  "org.gnome.SettingsDaemon.Sharing"
	  "org.gnome.SettingsDaemon.Smartcard"
	  "org.gnome.SettingsDaemon.Sound"
	  "org.gnome.SettingsDaemon.Wacom"
	)
	local reqc="${components[@]}"
	reqc="RequiredComponents=${reqc// /;};"
	sed -e 's|^Kiosk=true|#Kiosk=true|g' \
	  -i "${D}"/usr/share/gnome-session/sessions/gnome-login.session
	echo "${reqc}" >> "${D}"/usr/share/gnome-session/sessions/gnome-login.session
}
pkg_postinst() {
	gnome3_pkg_postinst
	local d ret
	# bug #669146; gdm may crash if /var/lib/gdm subdirs are not owned by gdm:gdm
	ret=0
	ebegin "Fixing ${EROOT}/var/lib/gdm ownership"
	chown --no-dereference gdm:gdm "${EROOT}/var/lib/gdm" || ret=1
	for d in "${EROOT}/var/lib/gdm/"{.cache,.color,.config,.dbus,.local}; do
	  [[ ! -e "${d}" ]] || chown --no-dereference -R gdm:gdm "${d}" || ret=1
	done
	eend ${ret}
	if use systemd ; then
	  systemd_reenable gdm.service
	fi
	udev_reload
}
pkg_postrm() {
	gnome3_pkg_postrm
	udev_reload
}


# vim: filetype=ebuild
