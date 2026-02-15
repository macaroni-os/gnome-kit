# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Base library for writing document import filters"
HOMEPAGE="https://sourceforge.net/p/libwpd/wiki/librevenge/"
SRC_URI="https://downloads.sourceforge.net/project/libwpd/librevenge/librevenge-0.0.5/librevenge-0.0.5.tar.xz -> librevenge-0.0.5.tar.xz"
LICENSE="LGPL-2.1-or-later OR MPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="doc"
BDEPEND="doc? ( app-doc/doxygen[dot] )
	
"
RDEPEND="sys-libs/zlib
	
"
DEPEND="${RDEPEND}
	dev-libs/boost
	
"
src_configure() {
	ECONF_SOURCE=${S} \
	econf \
	  --disable-static \
	  --disable-werror \
	  --disable-tests
	  $(use_with doc docs)
}
src_install() {
	default
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
