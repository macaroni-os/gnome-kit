# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic gnome3 meson python-single-r1

DESCRIPTION="Provides core UI functions for the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-shell"
SRC_URI="https://download.gnome.org/sources/gnome-shell/49/gnome-shell-49.2.tar.xz -> gnome-shell-49.2.tar.xz"
LICENSE="GPL2-2+ LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+X elogind +ibus gtk-doc +networkmanager pipewire systemd wayland"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
?? ( elogind systemd )
"
# Commons depends
CDEPEND="gnome-extra/evolution-data-server:=
	app-crypt/gcr:4[introspection]
	dev-libs/glib:2
	dev-libs/gobject-introspection:=
	dev-libs/gjs[cairo(+)]
	x11-libs/gtk:4[X?,introspection,wayland?]
	x11-wm/mutter[introspection]
	sys-auth/polkit[introspection]
	gnome-base/gsettings-desktop-schemas[introspection]
	app-i18n/ibus
	dev-python/docutils
	gnome-base/gnome-desktop:=
	networkmanager? (
	  net-misc/networkmanager[introspection]
	  net-libs/libnma[introspection]
	  app-crypt/libsecret
	)
	pipewire? ( media-video/pipewire:= )
	systemd? (
	  sys-apps/systemd:=
	  gnome-base/gnome-desktop[systemd]
	)
	elogind? ( sys-auth/elogind )
	app-arch/gnome-autoar
	dev-libs/json-glib
	app-accessibility/at-spi2-core:2[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	dev-libs/libxml2:=
	x11-libs/libX11
	media-sound/pulseaudio[glib]
	dev-libs/libical:=
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/gtk:4[introspection]
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	media-libs/libglvnd[X]
	!gnome-base/gnome-shell-common
	
"
BDEPEND="dev-util/meson
	dev-libs/libxslt
	dev-util/gdbus-codegen
	gtk-doc? (
	  dev-uti/gtk-doc
	  dev-util/gi-docgen
	  app-text/docbook-xml-dtd:4.5
	)
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="sys-apps/accountsservice[introspection]
	app-accessibility/at-spi2-core:2[introspection]
	app-misc/geoclue[introspection]
	media-libs/graphene[introspection]
	x11-libs/pango[introspection]
	net-libs/libsoup:3[introspection]
	sys-power/upower:=[introspection]
	gnome-base/librsvg:2[introspection]
	x11-libs/libadwaita[introspection]
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	x11-misc/xdg-utils
	x11-themes/adwaita-icon-theme
	networkmanager? (
	  net-misc/mobile-broadband-provider-info
	  sys-libs/timezone-data
	)
	ibus? ( app-i18n/ibus[gtk3,gtk4,introspection] )
	media-fonts/adwaita-fonts
	sys-apps/xdg-desktop-portal-gnome
	
"
DEPEND="${CDEPEND}
"
PDEPEND="gnome-base/gdm[introspection(+)]
	gnome-base/gnome-control-center[networkmanager(+)?]
	
"
src_prepare() {
	default
	xdg_environment_reset
	# Hack in correct python shebang
	sed -e "s:python\.full_path():'/usr/bin/env ${EPYTHON}':" -i src/meson.build || die
}
src_configure() {
	# It seems that -ldl is missed
	append-ldflags "-ldl"
	local emesonargs=(
	  $(meson_use pipewire camera_monitor)
	  -Dextensions_tool=true
	  -Dextensions_app=true
	  -Dman=true
	  -Dtests=false
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use networkmanager)
	  $(meson_use networkmanager portal_helper)
	  $(meson_use systemd)
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
