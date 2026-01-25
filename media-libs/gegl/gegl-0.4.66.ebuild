# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
VALA_USE_DEPEND=vapigen
inherit flag-o-matic meson python-any-r1 toolchain-funcs vala

DESCRIPTION="A graph based image processing framework"
HOMEPAGE="https://gegl.org/"
SRC_URI="https://download.gimp.org/gegl/0.4/gegl-0.4.66.tar.xz -> gegl-0.4.66.tar.xz"
LICENSE="|| ( GPL-3+ LGPL-3 )"
SLOT="0.4"
KEYWORDS="*"
IUSE="cairo debug ffmpeg introspection jpeg2k lcms
openexr openmp pdf raw sdl sdl2 svg tiff umfpack vala
v4l webp
"
REQUIRED_USE="svg? ( cairo )
vala? ( introspection )
"
BDEPEND="${PYTHON_DEPS}
	dev-lang/perl
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	>=media-libs/babl-0.1.118[introspection?,lcms?,vala?]
	media-libs/libjpeg-turbo:=
	media-libs/libnsgif:=
	media-libs/libpng:=
	sys-libs/zlib
	x11-libs/gdk-pixbuf
	x11-libs/pango
	cairo? ( x11-libs/cairo )
	ffmpeg? ( media-video/ffmpeg:= )
	introspection? ( dev-libs/gobject-introspection:= )
	jpeg2k? ( media-libs/jasper:= )
	lcms? ( media-libs/lcms )
	openexr? ( media-libs/openexr:= )
	pdf? ( app-text/poppler[cairo] )
	raw? ( media-libs/libraw:= )
	sdl? ( media-libs/libsdl )
	sdl2? ( media-libs/libsdl2 )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff:= )
	umfpack? ( media-libs/umfpack )
	v4l? ( media-libs/libv4l )
	webp? ( media-libs/libwebp:= )
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_prepare() {
	default
	# patch executables suffix
	sed -i -e "s/'gegl'/'gegl-0.4'/" bin/meson.build || die
	sed -i -e "s/'gegl-imgcmp'/'gegl-imgcmp-0.4'/" tools/meson.build || die
	sed -i -e "s/gegl-imgcmp/gegl-imgcmp-0.4/" tests/simple/test-exp-combine.py || die
	# skip UNEXPECTED PASSED 'matting-levin' test
	sed -i -e "s/composition_tests += 'matting-levin'//" \
	  -e "s/composition_tests_fail += 'matting-levin'//" tests/compositions/meson.build || die
	use vala && vala_src_prepare
}
src_configure() {
	filter-lto
	local emesonargs=(
	  -Ddocs=false  # website
	  -Dgi-docgen=disabled
	  -Dworkshop=false
	  $(meson_use introspection)
	  $(meson_feature vala vapigen)
	  # Optional dependencies (as per upstream)
	  -Dgdk-pixbuf=enabled
	  -Dgexiv2=disabled
	  # - Noop option. Its fully optional at runtime.
	  -Dgraphviz=disabled
	  $(meson_feature jpeg2k jasper)
	  $(meson_feature lcms)
	  # - Needs -Dworkshop=true
	  -Dlensfun=disabled
	  $(meson_feature ffmpeg libav)
	  $(meson_feature raw libraw)
	  $(meson_feature svg librsvg)
	  # - Not in portage main tree
	  -Dlibspiro=disabled
	  $(meson_feature tiff libtiff)
	  # - v4l support does not work with our media-libs/libv4l-0.8.9,
	  #   upstream bug at https://bugzilla.gnome.org/show_bug.cgi?id=654675
	  $(meson_feature v4l libv4l)
	  $(meson_feature v4l libv4l2)
	  -Dlua=disabled
	  -Dmrg=disabled
	  # - Unpackaged, needs -Dworkshop=true
	  #   Implementation of the feature in gimp stalled
	  #   https://gitlab.gnome.org/GNOME/gimp/-/issues/2912
	  -Dmaxflow=disabled
	  $(meson_feature openexr)
	  $(meson_feature openmp)
	  $(meson_feature cairo)
	  -Dpango=enabled
	  $(meson_feature cairo pangocairo)
	  $(meson_feature pdf poppler)
	  -Dpygobject=disabled
	  $(meson_feature sdl sdl1)
	  $(meson_feature sdl2 sdl2)
	  $(meson_feature umfpack)
	  $(meson_feature webp)
	)
	meson_src_configure
}


# vim: filetype=ebuild
