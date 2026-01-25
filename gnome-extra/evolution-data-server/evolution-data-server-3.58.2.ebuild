# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
VALA_USE_DEPEND="vapigen"
inherit cmake db-use flag-o-matic gnome3 vala

DESCRIPTION="Evolution groupware backend"
HOMEPAGE="https://wiki.gnome.org/Apps/Evolution"
SRC_URI="https://download.gnome.org/sources/evolution-data-server/3.58/evolution-data-server-3.58.2.tar.xz -> evolution-data-server-3.58.2.tar.xz"
LICENSE="|| ( LGPL-2 LGPL-3 ) BSD Sleepycat"
SLOT="0/62"
KEYWORDS="*"
IUSE="api-doc-extras -berkdb +gnome-online-accounts +gtk +google
+introspection ipv6 ldap kerberos vala +weather oauth-gtk3
oauth-gtk4
"
REQUIRED_USE="vala? ( introspection )
oauth-gtk3? ( gtk )
oauth-gtk4? ( gtk )
"
BDEPEND="virtual/pkgconfig
	sys-devel/gettext
	
"
RDEPEND="app-crypt/gcr
	app-crypt/libsecret[crypt]
	dev-db/sqlite:=
	dev-libs/glib:2
	dev-libs/libical:=
	dev-libs/libxml2
	dev-libs/nspr:=
	dev-libs/nss:=
	net-libs/libsoup:2.4
	dev-libs/icu:=
	sys-libs/zlib:=
	virtual/libiconv
	berkdb? ( sys-libs/db:18.1 )
	gtk? (
	  x11-libs/gtk+:3
	  x11-libs/gtk:4
	  oauth-gtk3? ( net-libs/webkit-gtk:4 )
	  oauth-gtk4? ( net-libs/webkit-gtk:6 )
	)
	google? (
	  dev-libs/json-glib
	  net-libs/webkit-gtk
	  dev-libs/libgdata:=
	)
	gnome-online-accounts? (
	  net-libs/gnome-online-accounts:=
	  dev-libs/libgdata:=
	)
	introspection? ( dev-libs/gobject-introspection:= )
	kerberos? ( virtual/krb5:= )
	ldap? ( net-nds/openldap:= )
	weather? ( dev-libs/libgweather:= )
	media-libs/libcanberra
	
"
DEPEND="${RDEPEND}
	dev-util/gperf
	dev-util/gtk-doc-am
	dev-util/intltool
	gnome-base/gnome-common
	vala? ( $(vala_depend) )
	
"
src_prepare() {
	use vala && vala_src_prepare
	cmake_src_prepare
	# Make CMakeLists versioned vala enabled
	sed -e "s;\(find_program(VALAC\) valac);\1 ${VALAC});" \
	  -e "s;\(find_program(VAPIGEN\) vapigen);\1 ${VAPIGEN});" \
	  -i "${S}"/CMakeLists.txt || die

}
src_configure() {
	local mycmakeargs=(
	  -DSYSCONF_INSTALL_DIR="/etc"
	  -DENABLE_GOA=$(usex gnome-online-accounts)
	  -DENABLE_OAUTH2=ON
	  -DENABLE_GTK=$(usex gtk)
	  -DENABLE_GTK_DOC=$(usex api-doc-extras)
	  -DENABLE_INTROSPECTION=$(usex introspection)
	  -DENABLE_IPV6=$(usex ipv6)
	  -DENABLE_VALA_BINDINGS=$(usex vala)
	  -DENABLE_WEATHER=$(usex weather)
	  -DWITH_PRIVATE_DOCS=$(usex api-doc-extras "ON" "OFF")
	  -DWITH_OPENLDAP=$(usex ldap "ON" "OFF")
	  -DWITH_KRB5=$(usex kerberos "ON" "OFF")
	  -DWITH_KRB5_LIBS=$(usex kerberos "${EPREFIX}"/usr/$(get_libdir) "")
	  -DWITH_CFLAGS=$(usex berkdb "-I$(db_includedir)" "")
	  -DENABLE_LARGEFILE=ON
	  -DENABLE_SMIME=ON
	  -DWITH_SYSTEMDUSERUNITDIR="$(systemd_get_userunitdir)"
	  -DENABLE_OAUTH2_WEBKITGTK=$(usex oauth-gtk3)
	  -DENABLE_OAUTH2_WEBKITGTK4=$(usex oauth-gtk4)
	  -DWITH_PHONENUMBER=OFF
	  -DENABLE_EXAMPLES=OFF
	  -DENABLE_UOA=OFF
	  -DENABLE_LIBCANBERRA=ON
	  -DENABLE_CANBERRA=ON
	  -DENABLE_TESTS=OFF
	)
	if use berkdb; then
	  mycmakeargs+=(
	    -DWITH_LIBDB=/usr
	    -DWITH_LIBDB_CFLAGS=-I/usr/include/db18.1
	    -DWITH_LIBDB_LIBS=-ldb-18.1
	  )
	else
	  mycmakeargs+=( -DWITH_LIBDB=OFF )
	fi
	 if use google || use gnome-online-accounts; then
	  mycmakeargs+=( -DENABLE_GOOGLE=ON )
	else
	  mycmakeargs+=( -DENABLE_GOOGLE=OFF )
	fi
	 cmake_src_configure
}
src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
	if use ldap; then
	  insinto /etc/openldap/schema
	  doins "${FILESDIR}"/calentry.schema
	  dosym /usr/share/${PN}/evolutionperson.schema /etc/openldap/schema/evolutionperson.schema
	fi
}


# vim: filetype=ebuild
