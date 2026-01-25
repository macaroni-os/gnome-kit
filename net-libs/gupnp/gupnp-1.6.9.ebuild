# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1 vala xdg

DESCRIPTION="An object-oriented framework for creating UPnP devs and control points"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gupnp"
SRC_URI="https://download.gnome.org/sources/gupnp/1.6/gupnp-1.6.9.tar.xz -> gupnp-1.6.9.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="1.6"
KEYWORDS="*"
IUSE="connman gtk-doc +introspection networkmanager vala"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
?? ( connman networkmanager )
"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.1.2
	  app-text/docbook-xml-dtd:4.2
	)
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	virtual/pkgconfig
	vala? (
	  $(vala_depend)
	  net-libs/gssdp:1.6[vala]
	  net-libs/libsoup:3[vala]
	)
	
"
RDEPEND="dev-libs/glib:2
	net-libs/gssdp:1.6=
	net-libs/libsoup
	dev-libs/libxml2:=
	sys-apps/util-linux
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
	sed -i -e '/-Werror=deprecated-declarations/d' meson.build || die
}
src_configure() {
	local backend=linux
	use connman && backend=connman
	use networkmanager && backend=network-manager
	local emesonargs=(
	  -Dcontext_manager=${backend}
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	  -Dexamples=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/gupnp-binding-tool-1.6
	if use gtk-doc ; then
	  mkdir "${ED}"/usr/share/gtk-doc || die
	  mv "${ED}"/usr/share/{doc,gtk-doc}/gupnp-1.6 || die
	fi
}


# vim: filetype=ebuild
