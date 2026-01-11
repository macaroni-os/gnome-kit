# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1

DESCRIPTION="C library for the Public Suffix List"
HOMEPAGE="https://rockdaboot.github.io/libpsl"
SRC_URI="https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz -> libpsl-0.21.5-ba4c49a.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="icu +idn static-libs"
BDEPEND="${PYTHON_DEPS}
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="icu? ( !idn? ( dev-libs/icu:= ) )
	idn? (
	  dev-libs/libunistring:=
	  net-dns/libidn2:=
	)
	
"
DEPEND="${RDEPEND}
"
pkg_pretend() {
	if use icu && use idn ; then
	  ewarn "\"icu\" and \"idn\" USE flags are enabled. Using \"idn\"."
	fi
}
src_configure() {
	local emesonargs=(
	  -Dtests=false
	)
	# Prefer idn even if icu is in USE as well
	if use idn ; then
	  emesonargs+=(
	    -Druntime=libidn2
	    -Dbuiltin=true
	  )
	elif use icu ; then
	  emesonargs+=(
	    -Druntime=libicu
	    -Dbuiltin=true
	  )
	else
	  emesonargs+=(
	    -Druntime=no
	  )
	fi
	if use static-libs ; then
	  emesonargs+=(
	    -Ddefault_library=both
	  )
	fi
	meson_src_configure
}


# vim: filetype=ebuild
