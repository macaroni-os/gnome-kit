# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools bash-completion-r1 tmpfiles

DESCRIPTION="USBGuard is a software framework for implementing USB device authorization policies (what kind of USB devices are authorized) as well as method of use policies (how a USB device may interact with the system)"
HOMEPAGE="https://usbguard.github.io/"
SRC_URI="https://api.github.com/repos/USBGuard/usbguard/tarball/usbguard-1.1.4 -> usbguard-1.1.4-f222331.tar.gz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="dbus ldap policykit static-libs systemd"
# Commons depends
CDEPEND="dev-libs/pegtl
	dev-libs/libsodium:=
	dev-libs/protobuf:=
	sys-cluster/libqb:=
	sys-libs/libcap-ng
	sys-libs/libseccomp
	sys-process/audit
	dbus? (
	  dev-libs/glib:2
	  sys-apps/dbus
	  sys-auth/polkit[introspection]
	)
	ldap? ( net-nds/openldap:= )
	systemd? ( sys-apps/systemd )
	
"
RDEPEND="${CDEPEND}
	virtual/udev
	
"
DEPEND="${CDEPEND}
	app-text/asciidoc
	dbus? (
	  dev-libs/libxml2
	  dev-libs/libxslt
	  dev-util/gdbus-codegen
	)
	
"

post_src_unpack() {
	mv USBGuard-usbguard-* ${S}
}


src_prepare() {
	default
	eautoreconf
}
src_configure() {
	local myargs=(
	  --with-bash-completion-dir=$(get_bashcompdir)
	  --localstatedir=/var
	  --disable-umockdev
	  --disable-catch
	  $(use_with dbus)
	  $(use_with dbus polkit)
	  $(use_with ldap)
	  $(use_enable static-libs static)
	  $(use_enable systemd)
	)
	econf "${myargs[@]}"
}
src_install() {
	default
	keepdir /etc/usbguard/IPCAccessControl.d  # bug 808801
	keepdir /etc/usbguard/rules.d  # bug 933878
	chmod 0600 "${ED}"/etc/usbguard/IPCAccessControl.d/.keep* || die  # bug 808801
	chmod 0600 "${ED}"/etc/usbguard/rules.d/.keep* || die  # bug 933878
	if ! use systemd ; then
	  newinitd "${FILESDIR}"/usbguard.openrc usbguard
	  use dbus && newinitd "${FILESDIR}"/usbguard-dbus.openrc usbguard-dbus
	fi
	find "${D}" -name '*.la' -delete || die  # bug 850655
	rmdir -p "${D}"/var/log/usbguard  # see pkg_postinst; bug 960270
}
pkg_postinst() {
	tmpfiles_process usbguard.conf
	ewarn
	ewarn 'BEFORE STARTING USBGUARD please be sure to create/generate'
	ewarn '                         a rules file at /etc/usbguard/rules.conf'
	ewarn '                         so that you do not'
	ewarn '                                            GET LOCKED OUT'
	ewarn "                         of this system (\"$(hostname)\")."
	ewarn
	ewarn 'This command may be of help:'
	ewarn '  sudo sh -c "usbguard generate-policy > /etc/usbguard/rules.conf"'
	ewarn
}



# vim: filetype=ebuild
