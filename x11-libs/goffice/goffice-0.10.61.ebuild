# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="A library of document-centric objects and utilities"
HOMEPAGE="https://gitlab.gnome.org/GNOME/goffice"
SRC_URI="https://download.gnome.org/sources/goffice/0.10/goffice-0.10.61.tar.xz -> goffice-0.10.61.tar.xz"
LICENSE="GPL-2"
SLOT="0.10"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="app-text/libspectre:=
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	gnome-base/librsvg
	gnome-extra/libgsf:=[introspection?]
	x11-libs/cairo:=
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango:=
	x11-libs/libXext
	x11-libs/libXrender:=
	introspection? (
	  dev-libs/gobject-introspection:=
	  gnome-extra/libgsf:=
	)
	
"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/gtk-doc-am
	dev-util/intltool
	virtual/perl-Compress-Raw-Zlib
	virtual/perl-Getopt-Long
	virtual/perl-IO-Compress
	
"
src_configure() {
	gnome3_src_configure \
	  --without-lasem \
	  --with-gtk \
	  --with-config-backend=gsettings \
	  $(use_enable introspection)
}


# vim: filetype=ebuild
