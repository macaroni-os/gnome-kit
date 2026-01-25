# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND=vapigen
inherit gnome3 meson vala

DESCRIPTION="A dynamic, any to any, pixel format conversion library"
HOMEPAGE="https://gegl.org/babl/"
SRC_URI="https://download.gimp.org/babl/0.1/babl-0.1.118.tar.xz -> babl-0.1.118.tar.xz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="introspection lcms vala cpu_flags_x86_avx2 cpu_flags_x86_f16c
cpu_flags_x86_mmx cpu_flags_x86_sse cpu_flags_x86_sse2
cpu_flags_x86_sse4_1
"
BDEPEND="virtual/pkgconfig
	vala? ( $(vala_depend) )
	
"
RDEPEND="introspection? ( dev-libs/gobject-introspection:= )
	lcms? ( media-libs/lcms )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	gnome3_environment_reset
	use vala && vala_src_prepare
}
src_configure() {
	# Automagic rsvg support is just for website generation we do not call,
	#     so we don't need to fix it
	# w3m is used for dist target thus no issue for us that it is automagically
	#     detected
	local emesonargs=(
	  -Dwith-docs=false
	  $(meson_use introspection enable-gir)
	  $(meson_feature lcms with-lcms)
	  $(meson_use vala enable-vapi)
	  $(meson_use cpu_flags_x86_avx2 enable-avx2)
	  $(meson_use cpu_flags_x86_f16c enable-f16c)
	  $(meson_use cpu_flags_x86_mmx enable-mmx)
	  $(meson_use cpu_flags_x86_sse enable-sse)
	  $(meson_use cpu_flags_x86_sse2 enable-sse2)
	  $(meson_use cpu_flags_x86_sse4_1 enable-sse4_1)
	)
	meson_src_configure
}


# vim: filetype=ebuild
