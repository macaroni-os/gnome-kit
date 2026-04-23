# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson systemd gnome3

DESCRIPTION="System-wide Linux Profiler"
HOMEPAGE="https://www.sysprof.com/"
SRC_URI="https://download.gnome.org/sources/sysprof/49/sysprof-49.0.tar.xz -> sysprof-49.0.tar.xz"
LICENSE="GPL-3+ GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk systemd"
BDEPEND="dev-libs/appstream-glib
	dev-util/gdbus-codegen
	sys-devel/gettext
	sys-kernel/linux-headers
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	gtk? (
	  x11-libs/gtk:4
	  x11-libs/libadwaita
	  x11-libs/cairo
	  x11-libs/pango
	)
	systemd? ( sys-apps/systemd )
	dev-libs/json-glib
	dev-libs/libdex
	x11-libs/libpanel
	sys-libs/libunwind:=
	sys-auth/polkit
	dev-libs/elfutils
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	gnome3_environment_reset
}
src_configure() {
	local emesonargs=(
	  $(meson_use gtk)
	  -Dlibsysprof=true
	  -Dinstall-static=false
	  -Dsysprofd=bundled
	  -Dsystemdunitdir=$(systemd_get_systemunitdir)
	  # -Ddebugdir
	  -Dhelp=true
	  -Dtools=true
	  -Dtests=false
	  -Dexamples=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_preinst() {
	gnome3_pkg_preinst
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
