# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-r1 vala

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gitg"
SRC_URI="https://download.gnome.org/sources/gitg/44/gitg-44.tar.xz -> gitg-44.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+glade +python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	
"
RDEPEND="app-crypt/gpgme:=
	app-crypt/libsecret[vala]
	app-text/gspell:=[vala]
	dev-libs/glib:2[dbus]
	dev-libs/gobject-introspection:=
	dev-libs/json-glib
	dev-libs/libdazzle[vala]
	dev-libs/libgee[introspection]
	dev-libs/libgit2-glib[ssh,vala]
	dev-libs/libgit2:=[threads]
	dev-libs/libpeas[gtk]
	dev-libs/libxml2:=
	gnome-base/gsettings-desktop-schemas
	dev-libs/libhandy
	x11-libs/gtk+:3
	x11-libs/gtksourceview:4
	x11-themes/adwaita-icon-theme
	glade? ( dev-util/glade )
	python? (
	  ${PYTHON_DEPS}
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	)
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	echo "#!/bin/sh" > meson_post_install.py || die
	vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  $(meson_use glade glade_catalog)
	  -Dpython=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use python ; then
	  python_moduleinto gi.overrides
	  python_foreach_impl python_domodule libgitg-ext/GitgExt.py
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
