# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME3_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"
inherit autotools eutils gnome3 vala ltprune memsaver

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
SRC_URI="https://distfiles.macaronios.org/19/b4/26/19b4264e9cdf0adce4d03a0e24a6159ad1be72f3c7ad48c116ed8eb3e440da1451a5051ede11d56c842ded38194aac3ec3d4fecc74c5dcc2cb067e22faf48f21 -> librsvg-2.54.5.tar.xz
https://download.gnome.org/sources/librsvg/2.54/librsvg-2.54.5.tar.xz -> librsvg-2.54.5.tar.xz"
LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="*"

IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="gtk-doc? ( introspection ) vala? ( introspection )"
RDEPEND="
	>=dev-libs/glib-2.62.2:2
	>=x11-libs/cairo-1.16.0
	>=x11-libs/pango-1.44.7
	>=dev-libs/libxml2-2.9.1:2
	>=dev-libs/libcroco-0.6.8
	>=x11-libs/gdk-pixbuf-2.39.2:2[introspection?]
	>=virtual/rust-1.41
	introspection? ( >=dev-libs/gobject-introspection-1.62.0:= )
"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	dev-libs/vala-common
	gtk-doc? ( dev-util/gi-docgen )
	virtual/rust
	vala? ( $(vala_depend) )
	>=virtual/pkgconfig-0-r1
"
src_prepare() {
	eautoreconf
	gnome3_src_prepare
	use vala && vala_src_prepare
}

src_configure() {
	memsaver_src_configure
	ECONF_SOURCE=${S} \
	gnome3_src_configure \
		--disable-debug \
		--disable-static \
		$(use_enable gtk-doc) \
		$(use_enable introspection) \
		$(use_enable vala) \
		--enable-pixbuf-loader

	ln -s "${S}"/doc/html doc/html || die
}

src_compile() {
	# causes segfault if set, see bug #411765
	unset __GL_NO_DSO_FINALIZER
	gnome3_src_compile
}

pkg_postinst() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER
	gnome3_pkg_postinst
}

pkg_postrm() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER
	gnome3_pkg_postrm
}