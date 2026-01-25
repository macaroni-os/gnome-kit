# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Parsing Expression Grammar Template Library"
HOMEPAGE="https://github.com/taocpp/PEGTL"
SRC_URI="https://api.github.com/repos/taocpp/PEGTL/tarball/refs/tags/3.2.8 -> pegtl-3.2.8-be52732.tar.gz"
LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv taocpp-PEGTL-* ${S}
}


src_prepare() {
	# Disable Werror
	sed -i -e 's|-Werror||g' Makefile || die
	sed -i -e 's|-Werror||g' src/example/pegtl/CMakeLists.txt || die
	sed -i -e 's|-Werror||g' src/test/pegtl/CMakeLists.txt || die
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DPEGTL_INSTALL_CMAKE_DIR="$(get_libdir)/cmake/pegtl"
	  -DPEGTL_INSTALL_DOC_DIR="share/doc/pegtl-3.2.8"
	)
	cmake_src_configure
}



# vim: filetype=ebuild
