# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala xdg

DESCRIPTION="GNOME framework for accessing online accounts"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-online-accounts"
SRC_URI="https://download.gnome.org/sources/gnome-online-accounts/3.56/gnome-online-accounts-3.56.3.tar.xz -> gnome-online-accounts-3.56.3.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="debug doc gnome +introspection kerberos ms365 +vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="doc? ( dev-util/gi-docgen )
	
"
RDEPEND="dev-libs/glib:2
	sys-apps/dbus
	introspection? ( dev-libs/gobject-introspection:= )
	x11-libs/libadwaita
	x11-libs/gtk:4
	dev-libs/json-glib
	app-crypt/libsecret
	net-libs/libsoup:3
	sys-apps/keyutils
	dev-libs/libxml2:2=
	kerberos? (
	  app-crypt/gcr[gtk]
	  app-crypt/mit-krb5
	)
	
"
DEPEND="${RDEPEND}
	vala? ( $(vala_depend) )
	dev-libs/libxslt
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/gobject-introspection-common
	gnome-base/gnome-common
	
"
PDEPEND="gnome? ( gnome-base/gnome-control-center[gnome-online-accounts(+)] )
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dgoabackend=true
	  -Dexchange=true
	  -Dfedora=false
	  -Dgoogle=true
	  -Dimap_smtp=true
	  -Downcloud=true
	  -Dwebdav=true
	  -Dman=true
	  $(meson_use kerberos)
	  $(meson_use doc documentation)
	  $(meson_use ms365 ms_graph)
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use doc; then
	  mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${PF} || die
	fi
}


# vim: filetype=ebuild
