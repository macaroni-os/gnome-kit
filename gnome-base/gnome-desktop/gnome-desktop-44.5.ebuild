# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg

DESCRIPTION="Library with common API for various GNOME modules"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-desktop"
SRC_URI="https://download.gnome.org/sources/gnome-desktop/44/gnome-desktop-44.5.tar.xz -> gnome-desktop-44.5.tar.xz"
LICENSE="GPL-2+ LGPL-2+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
IUSE="debug gtk-doc seccomp systemd udev"
BDEPEND="app-text/docbook-xml-dtd:4.1.2
	dev-util/gdbus-codegen
	gtk-doc? ( dev-util/gtk-doc )
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="x11-libs/gdk-pixbuf[introspection]
	x11-libs/gtk:4[introspection]
	dev-libs/glib:2
	gnome-base/gsettings-desktop-schemas[introspection]
	x11-misc/xkeyboard-config
	x11-libs/libxkbcommon
	app-text/iso-codes
	systemd? ( sys-apps/systemd:= )
	udev? ( virtual/libudev:= )
	seccomp? ( sys-libs/libseccomp )
	x11-libs/cairo
	dev-libs/gobject-introspection:=
	!<gnome-base/gnome-desktop-44.5:3
	
"
DEPEND="${RDEPEND}
	media-libs/fontconfig
	
"
src_prepare() {
	default
	xdg_environment_reset
	# Don't build manual test programs that will never get run
	sed -i -e "/'test-.*'/d" libgnome-desktop/meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Ddesktop_docs=true
	  $(meson_use debug debug_tools)
	  $(meson_feature udev)
	  $(meson_feature systemd)
	  $(meson_use gtk-doc gtk_doc)
	  -Dinstalled_tests=false
	  -Dbuild_gtk4=true
	  -Dlegacy_library=true
	  -Dintrospection=true
	)
	meson_src_configure
}


# vim: filetype=ebuild
