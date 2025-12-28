# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Dictionary utility for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Dictionary"
SRC_URI="https://download.gnome.org/sources/gnome-dictionary/40/gnome-dictionary-40.0.tar.xz -> gnome-dictionary-40.0.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+ FDL-1.1+"
SLOT="0"
KEYWORDS="*"
IUSE="debug +introspection ipv6"
# Commons depends
CDEPEND="dev-libs/glib:2[dbus]
	x11-libs/cairo:=
	x11-libs/gtk+:3
	x11-libs/pango
	introspection? ( dev-libs/gobject-introspection:= )
	
"
BDEPEND="dev-util/gtk-doc-am
	dev-util/intltool
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	gnome-base/gsettings-desktop-schemas
	
"
DEPEND="${CDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Duse_ipv6=$(usex ipv6 true false)
	)
	sed -i -e "s|('appdata',|(|g" data/appdata/meson.build
	sed -i -e "s|('desktop',|(|g" \
	  -e "s|('sources',|(|g" data/meson.build
	meson_src_configure
}


# vim: filetype=ebuild
