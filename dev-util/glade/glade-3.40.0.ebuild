# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic gnome3 python-single-r1 meson

DESCRIPTION="A user interface designer for GTK+ and GNOME"
HOMEPAGE="https://glade.gnome.org https://gitlab.gnome.org/GNOME/glade"
SRC_URI="https://download.gnome.org/sources/glade/3.40/glade-3.40.0.tar.xz -> glade-3.40.0.tar.xz"
LICENSE="GPL-2+ FDL-1.1+"
SLOT="3.10/13"
KEYWORDS="*"
IUSE="X gjs gtk-doc +introspection python wayland webkit"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="${PYTHON_DEPS}
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.2
	)
	dev-libs/libxslt
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="app-accessibility/at-spi2-core[introspection?]
	dev-libs/glib:2
	dev-libs/libxml2:2=
	x11-libs/cairo:=
	x11-libs/gdk-pixbuf:2[introspection?]
	x11-libs/gtk+:3[X?,introspection?,wayland?]
	x11-libs/pango[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	gjs? ( dev-libs/gjs )
	python? (
	  ${PYTHON_DEPS}
	  x11-libs/gtk+:3[introspection]
	  $(python_gen_cond_dep '
	    dev-python/pygobject:3[${PYTHON_USEDEP}]
	  ')
	)
	webkit? ( net-libs/webkit-gtk:4.1 )
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_configure() {
	use X || append-cppflags -DGENTOO_GTK_HIDE_X11
	use wayland || append-cppflags -DGENTOO_GTK_HIDE_WAYLAND
	local emesonargs=(
	  -Dgladeui=true
	  $(meson_feature gjs)
	  $(meson_feature python)
	  $(meson_feature webkit webkit2gtk)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}


# vim: filetype=ebuild
