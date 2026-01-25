# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="GTK update icon cache"
HOMEPAGE="https://gitlab.gnome.org/Community/gentoo/gtk-update-icon-cache"
SRC_URI="https://gitlab.gnome.org/Community/gentoo/gtk-update-icon-cache/-/archive/3.24.42/gtk-update-icon-cache-3.24.42.tar.bz2 -> gtk-update-icon-cache-3.24.42.tar.bz2"
SLOT="0"
KEYWORDS="*"
BDEPEND="app-text/docbook-xml-dtd:4.3
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	
"
DEPEND="${RDEPEND}
"
src_install() {
	meson_src_install
	dosym /usr/bin/gtk-update-icon-cache /usr/bin/gtk4-update-icon-cache
}


# vim: filetype=ebuild
