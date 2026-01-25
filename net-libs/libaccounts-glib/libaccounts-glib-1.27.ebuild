# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1 vala

DESCRIPTION="Accounts SSO (Single Sign-On) management library for GLib applications"
HOMEPAGE="https://gitlab.com/accounts-sso/libaccounts-glib"
SRC_URI="https://gitlab.com/accounts-sso/libaccounts-glib/-/archive/VERSION_1.27/libaccounts-glib-VERSION_1.27.tar.bz2 -> libaccounts-glib-1.27.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="$(vala_depend)
	dev-util/gdbus-codegen
	virtual/pkgconfig
	
"
RDEPEND="${PYTHON_DEPS}
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/gobject-introspection:=
	dev-libs/libxml2:=
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/libaccounts-glib-VERSION_1.27"
pkg_setup() {
	python-single-r1_pkg_setup
}
src_prepare() {
	default
	vala_src_prepare --ignore-use
	sed -e "/^subdir('docs')$/d" -i meson.build || die
	sed -e "/^subdir('tests')$/d" -i meson.build || die
	# /tmp isn't accessible from sandbox
	sed -i -e "s|/tmp/\(.*\)|${T}/\1|" tests/check_ag.c || die
	sed -i -e "s|/tmp|${T}|" tests/meson.build || die
}

src_configure() {
	local emesonargs=(
	  -Dinstall-py-overrides=true
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_optimize
}


# vim: filetype=ebuild
