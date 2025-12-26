# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
inherit autotools distutils-r1 flag-o-matic

DESCRIPTION="libiptcdata (from sf.net)"
HOMEPAGE="https://github.com/ianw/libiptcdata"
SRC_URI="https://github.com/ianw/libiptcdata/releases/download/release_1_0_5/libiptcdata-1.0.5.tar.gz -> libiptcdata-1.0.5.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="doc examples python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
BDEPEND="dev-util/gtk-doc-am
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )
	sys-devel/gettext
	python? (
	  ${PYTHON_DEPS}
	)
	
"
RDEPEND="python? ( ${PYTHON_DEPS} )
	
"
src_prepare() {
	default
	eautoreconf
	if use python; then
	  cd python || die
	  ln -s "../${PN}" . || die
	  distutils-r1_src_prepare
	fi
}
src_configure () {
	local myeconfargs=(
	  $(use_enable python)
	  $(use_enable doc gtk-doc)
	)
	econf "${myeconfargs[@]}"
	if use python; then
	  # Workaround about include/linking issue
	  # with libiptcdata
	  append-cflags "-I."
	  append-ldflags "-L./libiptcdata/.libs"
	  cd python || die
	  distutils-r1_src_configure
	fi
}
src_compile() {
	default
	if use python; then
	  cd python || die
	  distutils-r1_src_compile
	fi
}
src_install () {
	default
	find "${D}" -name '*.la' -delete || die "failed to remove *.la files"
	if use python; then
	  cd python || die
	  distutils-r1_src_install
	fi
	if use examples; then
	  dodoc python/README
	  dodoc -r python/examples
	fi
}


# vim: filetype=ebuild
