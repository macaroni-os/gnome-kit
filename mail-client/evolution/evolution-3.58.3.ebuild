# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake gnome3

DESCRIPTION="Integrated mail, addressbook and calendaring functionality"
HOMEPAGE="https://gitlab.gnome.org/GNOME/evolution/-/wikis/home https://gitlab.gnome.org/GNOME/evolution"
SRC_URI="https://download.gnome.org/sources/evolution/3.58/evolution-3.58.3.tar.xz -> evolution-3.58.3.tar.xz"
LICENSE="|| ( LGPL-2 LGPL-3 ) CC-BY-SA-3.0 FDL-1.3+ OPENLDAP"
SLOT="2.0"
KEYWORDS="*"
IUSE="archive +bogofilter geolocation gtk-doc highlight ldap libnotify sound
spamassassin spell ssl +weather ytnef
"
BDEPEND="app-text/docbook-xml-dtd:4.1.2
	dev-util/gdbus-codegen
	dev-util/itstool
	gtk-doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="app-crypt/libsecret
	app-text/enchant
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libxml2:=
	gnome-base/gnome-desktop:=
	gnome-base/gsettings-desktop-schemas
	>=gnome-extra/evolution-data-server-3.58.3:=[gtk,weather?]
	net-libs/libsoup:3
	net-libs/webkit-gtk:4[spell?]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-misc/shared-mime-info
	app-text/cmark:=
	app-text/iso-codes
	app-accessibility/at-spi2-core:2
	gnome-base/dconf
	archive? ( app-arch/gnome-autoar[gtk] )
	bogofilter? ( mail-filter/bogofilter )
	geolocation? (
	  media-libs/libchamplain[gtk]
	  media-libs/clutter:1.0
	  media-libs/clutter-gtk:1.0
	  sci-geosciences/geocode-glib
	)
	ldap? ( net-dns/openldap:= )
	libnotify? ( x11-libs/libnotify )
	media-libs/libcanberra
	spamassassin? ( mail-filter/spamassassin )
	spell? (
	  app-text/gspell:=
	)
	ssl? (
	  dev-libs/libgweather
	  sci-geosciences/geocode-glib
	)
	ytnef? ( net-mail/ytnef )
	highlight? ( app-text/highlight )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	use libnotify || sed '/HAVE_LIBNOTIFY/d' -i CMakeLists.txt || die
	cmake_src_prepare
	gnome3_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DSYSCONF_INSTALL_DIR="${EPREFIX}"/etc
	  -DENABLE_SCHEMAS_COMPILE=OFF
	  -DENABLE_GTK_DOC=$(usex gtk-doc)
	  -DWITH_OPENLDAP=$(usex ldap)
	  -DENABLE_SMIME=$(usex ssl)
	  -DENABLE_GNOME_DESKTOP=ON
	  -DWITH_ENCHANT_VERSION=2
	  -DENABLE_CANBERRA=ON
	  -DENABLE_AUTOAR=$(usex archive)
	  -DWITH_HELP=ON
	  -DENABLE_YTNEF=OFF
	  -DWITH_BOGOFILTER=$(usex bogofilter)
	  -DWITH_SPAMASSASSIN=$(usex spamassassin)
	  -DENABLE_GSPELL=$(usex spell)
	  -DENABLE_TEXT_HIGHLIGHT=$(usex highlight)
	  -DENABLE_WEATHER=$(usex weather)
	  -DENABLE_CONTACT_MAPS=$(usex geolocation)
	  -DENABLE_YTNEF=$(usex ytnef)
	  -DENABLE_PST_IMPORT=OFF
	  -DWITH_GLADE_CATALOG=OFF
	  -DENABLE_MARKDOWN=ON
	)
	cmake_src_configure
}
src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
}
pkg_postinst() {
	gnome3_pkg_postinst
}


# vim: filetype=ebuild
