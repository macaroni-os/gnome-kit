# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND=vapigen
inherit cmake-utils vala

DESCRIPTION="Libical is an Open Source implementation of the iCalendar protocols and protocol data units."
HOMEPAGE="http://libical.github.io/libical/"
SRC_URI="https://github.com/libical/libical/releases/download/v3.0.20/libical-3.0.20.tar.gz -> libical-3.0.20-57ce340.tar.gz"
LICENSE="NOASSERTION"
SLOT="0/3"
KEYWORDS="*"
IUSE="berkdb doc examples +introspection static-libs +vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="dev-lang/perl
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/icu:=
	berkdb? ( sys-libs/db:= )
	introspection? (
	  dev-libs/libxml2
	  dev-libs/glib:2
	  dev-libs/gobject-introspection:=
	)
	sys-libs/timezone-data
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	cmake-utils_src_prepare
	use examples || cmake_comment_add_subdirectory examples
	use vala && vala_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  $(cmake-utils_use_find_package berkdb BDB)
	  -DICAL_BUILD_DOCS=$(usex doc)
	  -DICAL_GLIB=$(usex introspection)
	  -DGOBJECT_INTROSPECTION=$(usex introspection)
	  -DSHARED_ONLY=$(usex !static-libs)
	  -DLIBICAL_BUILD_TESTING=OFF
	  -DICAL_GLIB_VAPI=$(usex vala)
	)
	if use vala; then
	  mycmakeargs+=(
	    -DVALAC="${VALAC}"
	    -DVAPIGEN="${VAPIGEN}"
	  )
	fi
	cmake-utils_src_configure
}
src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile docs
}
src_install() {
	use doc && HTML_DOCS=( "${BUILD_DIR}"/apidocs/html/. )
	cmake-utils_src_install
	if use examples; then
	  rm examples/CMakeLists.txt || die
	  dodoc -r examples
	fi
}


# vim: filetype=ebuild
