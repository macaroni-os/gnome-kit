# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic meson

DESCRIPTION="Javascript bindings for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gjs"
SRC_URI="https://download.gnome.org/sources/gjs/1.86/gjs-1.86.0.tar.xz -> gjs-1.86.0.tar.xz"
LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
KEYWORDS="*"
IUSE="+clang examples readline sysprof"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libffi:=
	dev-libs/gobject-introspection:=
	dev-lang/spidermonkey
	x11-libs/cairo[X,glib]
	readline? ( sys-libs/readline:= )
	
"
DEPEND="${RDEPEND}
	sysprof? ( dev-util/sysprof )
	clang? (
	  sys-devel/clang:20
	  sys-devel/llvm:20
	  sys-devel/lld
	)
	
"
src_configure() {
	if use clang; then
	  export CPPFLAGS="${CPPFLAGS} -I/usr/lib/clang/20/include/"
	  local -x CC=${CHOST}-clang
	  local -x CXX=${CHOST}-clang++
	  strip-unsupported-flags
	fi
	 # TODO: check why OS is not correctly identified
	# and i need to add -DXP_UNIX
	append-cppflags -DG_DISABLE_CAST_CHECKS -DXP_UNIX
	local emesonargs=(
	  $(meson_feature readline)
	  $(meson_feature sysprof profiler)
	  -Dinstalled_tests=false
	  -Dskip_dbus_tests=true
	  -Dskip_gtk_tests=true
	  -Db_pch=True
	)
	meson_src_configure
}


# vim: filetype=ebuild
