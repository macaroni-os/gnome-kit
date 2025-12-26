# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 flag-o-matic gnome3 meson systemd vala

DESCRIPTION="Low-footprint RDF triple store with SPARQL 1.1 interface"
HOMEPAGE="https://gitlab.gnome.org/GNOME/tinysparql"
SRC_URI="https://download.gnome.org/sources/tinysparql/3.9/tinysparql-3.9.2.tar.xz -> tinysparql-3.9.2.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +localsearch stemmer systemd vala zeroconf"
BDEPEND="app-text/asciidoc
	dev-libs/libxslt
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? (
	  dev-uti/gi-docgen
	  media-gfx/graphviz
	  app-text/xmlto
	)
	${PYTHON_DEPS}
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/gobject-introspection:=
	dev-libs/icu:=
	dev-libs/json-glib
	dev-libs/libxml2
	dev-db/sqlite:3
	net-libs/libsoup
	sys-apps/dbus
	zeroconf? ( net-dns/avahi )
	systemd? ( sys-apps/systemd )
	stemmer? ( dev-libs/snowball-stemmer:= )
	
"
DEPEND="${RDEPEND}
"
PDEPEND="localsearch? ( app-misc/localsearch )
	
"
src_prepare() {
	default
	vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	append-cflags -DTRACKER_DEBUG -DG_DISABLE_CAST_CHECKS
	local emesonargs=(
	  $(meson_use gtk-doc docs)
	  $(meson_feature stemmer)
	  $(meson_feature zeroconf avahi)
	  $(meson_feature vala vapi)
	  -Dtests=false
	  -Dman=true
	  -Dunicode_support=icu
	  -Dbash_completion_dir="$(get_bashcompdir)"
	  -Dintrospection=enabled
	)
	if use systemd ; then
	  emesonargs+=(
	    -Dsystemd_user_services_dir="$(systemd_get_userunitdir)"
	  )
	else
	  emesonargs+=(
	    -Dsystemd_user_services_dir=false
	  )
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/Tsparql-3.0 "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
