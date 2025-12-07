# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit bash-completion-r1 meson udev tmpfiles vala user

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="https://www.freedesktop.org/software/colord/"
SRC_URI="https://www.freedesktop.org/software/colord/releases/colord-1.4.8.tar.xz -> colord-1.4.8.tar.xz"
LICENSE="GPL-2+"
SLOT="0/2"
KEYWORDS="*"
IUSE="gtk-doc examples extra-print-profiles +introspection scanner systemd vala"
REQUIRED_USE="vala? ( introspection )
"
RDEPEND="dev-libs/glib:2
	media-libs/lcms:=
	dev-db/sqlite:3=
	dev-libs/libgusb[introspection?]
	dev-libs/libgudev:=
	virtual/libudev:=
	virtual/udev
	systemd? (
	  sys-apps/systemd:=
	)
	scanner? (
	  media-gfx/sane-backends
	  sys-apps/dbus
	)
	sys-auth/polkit
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/gtk-doc-am
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
pkg_setup() {
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
	use vala && vala_src_prepare
}
src_prepare() {
	default
	sed -i -e "/find_program('vapigen')/d" meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Ddaemon=true
	  -Dbash_completion=false
	  -Dudev_rules=true
	  $(meson_use systemd)
	  -Dlibcolordcompat=true
	  $(meson_use scanner sane)
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use extra-print-profiles print_profiles)
	  -Dtests=false
	  -Dinstalled_tests=false
	  -Ddaemon_user=colord
	  -Dman=true
	  $(meson_use gtk-doc docs)
	  --localstatedir="${EPREFIX}"/var
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	newbashcomp data/colormgr colormgr
	einstalldocs
	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}
	if use examples; then
	  docinto examples
	  dodoc examples/*.c
	fi
}
pkg_postinst() {
	udev_reload
	tmpfiles_process colord.conf
}
pkg_postrm() {
	udev_reload
}


# vim: filetype=ebuild
