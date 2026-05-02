# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 vala meson

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="https://wiki.gnome.org/Apps/Geary"
SRC_URI="https://download.gnome.org/sources/geary/46/geary-46.0.tar.xz -> geary-46.0.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/geary_30105fd4c210c8ba4e875ab003cd393064ded894.patch"
)
IUSE="nls"
# Commons depends
CDEPEND="app-crypt/gcr:0=[gtk,introspection]
	app-crypt/libsecret
	app-text/iso-codes
	dev-db/sqlite:3
	dev-libs/glib:2[dbus]
	dev-libs/libgee:0.8=
	dev-libs/appstream-glib:0
	net-libs/gnome-online-accounts
	app-text/enchant
	dev-libs/folks:0
	dev-libs/json-glib
	dev-libs/libxml2:2
	dev-libs/gmime:3.0[vala]
	dev-libs/libpeas
	media-libs/libcanberra
	net-libs/webkit-gtk:4=[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify
	sys-libs/libunwind
	net-mail/ytnef
	app-text/gspell[introspection,vala]
	
"
RDEPEND="${CDEPEND}
	gnome-base/gsettings-desktop-schemas
	gnome-base/dconf
	nls? ( virtual/libintl )
	
"
DEPEND="${CDEPEND}
	app-text/gnome-doc-utils
	dev-util/desktop-file-utils
	nls? ( sys-devel/gettext )
	$(vala_depend)
	virtual/pkgconfig
	
"
src_prepare() {
	local i
	if use nls ; then
	  if [[ -n "${LINGUAS+x}" ]] ; then
	    for i in $(cd po ; echo *.po) ; do
	      if ! has ${i%.po} ${LINGUAS} ; then
	        sed -i -e "/^${i%.po}$/d" po/LINGUAS || die
	      fi
	    done
	  fi
	else
	  sed -i -e 's#add_subdirectory(po)##' CMakeLists.txt || die
	fi
	gnome3_src_prepare
	vala_src_prepare
}
pkg_postinst() {
	gnome3_pkg_postinst
	gnome3_schemas_update
}


# vim: filetype=ebuild
