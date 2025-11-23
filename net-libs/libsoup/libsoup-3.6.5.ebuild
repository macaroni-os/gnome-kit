# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit meson vala xdg

DESCRIPTION="HTTP client/server library for GNOME"
HOMEPAGE="https://libsoup.gnome.org"
SRC_URI="https://download.gnome.org/sources/libsoup/3.6/libsoup-3.6.5.tar.xz -> libsoup-3.6.5.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="*"
IUSE="brotli gssapi gtk-doc +introspection samba ssl +vala"
REQUIRED_USE="vala? ( introspection )"
# Commons depends
CDEPEND="dev-libs/glib:2
	net-libs/nghttp2:=
	dev-db/sqlite
	brotli? ( app-arch/brotli )
	net-libs/libpsl
	sys-libs/zlib
	gssapi?  ( virtual/krb5 )
	introspection? ( dev-libs/gobject-introspection:= )
	samba? ( net-fs/samba )
	
"
BDEPEND="gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.1.2
	)
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="${CDEPEND}
	net-libs/glib-networking[ssl?]
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	use vala && vala_src_prepare
	xdg_src_prepare
	# https://gitlab.gnome.org/GNOME/libsoup/issues/159 - could work with libnss-myhostname
	sed -e '/hsts/d' -i tests/meson.build || die
}
src_configure() {
	local emesonargs=(
	  # Avoid auto-magic, built-in feature of meson
	  -Dauto_features=enabled
	  $(meson_feature gssapi)
	  $(meson_feature samba ntlm)
	  $(meson_feature brotli)
	  -Dntlm_auth="${EPREFIX}/usr/bin/ntlm_auth"
	  -Dtls_check=false
	  $(meson_feature introspection)
	  $(meson_feature vala vapi)
	  $(meson_feature gtk-doc docs)
	  -Ddoc_tests=false
	  -Dtests=false
	  -Dautobahn=disabled
	  -Dinstalled_tests=false
	  -Dpkcs11_tests=disabled
	  -Dsysprof=disabled
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/libsoup-3.0 "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}


# vim: filetype=ebuild
