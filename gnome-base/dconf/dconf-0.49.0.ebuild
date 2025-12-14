# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson systemd vala

DESCRIPTION="Simple low-level configuration system"
HOMEPAGE="https://wiki.gnome.org/Projects/dconf"
SRC_URI="https://download.gnome.org/sources/dconf/0.49/dconf-0.49.0.tar.xz -> dconf-0.49.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc bash-completion"
BDEPEND="app-text/docbook-xml-dtd:4.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gdbus-codegen
	gtk-doc? ( dev-util/gtk-doc )
	sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="dev-libs/glib:2
	sys-apps/dbus
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
	  -Dman=true
	  -Dvapi=true
	  -Dsystemduserunitdir=$(systemd_get_userunitdir)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use bash-completion bash_completion)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# GSettings backend may be one of: memory, gconf, dconf
	# Only dconf is really considered functional by upstream
	# must have it enabled over gconf if both are installed
	# This snippet can't be removed until gconf package is
	# ensured to not install a /etc/env.d/50gconf and then
	# still consider the CONFIG_PROTECT_MASK bit.
	echo 'CONFIG_PROTECT_MASK="/etc/dconf"' >> 51dconf
	echo 'GSETTINGS_BACKEND="dconf"' >> 51dconf
	doenvd 51dconf
}
pkg_postinst() {
	gnome3_pkg_postinst
	# Kill existing dconf-service processes as recommended by upstream due to
	# possible changes in the dconf private dbus API.
	# dconf-service will be dbus-activated on next use.
	pids=$(pgrep -x dconf-service)
	if [[ $? == 0 ]]; then
	  ebegin "Stopping dconf-service; it will automatically restart on demand"
	  kill ${pids}
	  eend $?
	fi
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
