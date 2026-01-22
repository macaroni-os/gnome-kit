# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson toolchain-funcs

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
SRC_URI="https://download.gnome.org/sources/gtk/3.24/gtk-3.24.51.tar.xz -> gtk-3.24.51.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gtk+-3.24.36-update-icon-cache.patch"
)
IUSE="broadway cloudproviders colord cups examples gtk-doc +introspection sysprof vim-syntax wayland +X xinerama"
REQUIRED_USE="|| ( wayland X )
xinerama? ( X )
colord? ( cups )
"
# Commons depends
CDEPEND="app-accessibility/at-spi2-core[introspection?]
	dev-libs/fribidi
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/harfbuzz:=
	media-libs/libepoxy[X(+)?,egl(+)]
	virtual/libintl
	x11-libs/cairo[glib,X?]
	x11-libs/gdk-pixbuf:2[introspection?]
	x11-libs/pango[introspection?]
	x11-misc/shared-mime-info
	cloudproviders? ( net-libs/libcloudproviders )
	colord? ( x11-misc/colord:0= )
	cups? ( net-print/cups )
	introspection? ( dev-libs/gobject-introspection:= )
	wayland? (
	  dev-libs/wayland
	  dev-libs/wayland-protocols
	  media-libs/mesa[wayland]
	  x11-libs/libxkbcommon
	)
	X? (
	  media-libs/libglvnd[X(+)]
	  x11-libs/libX11
	  x11-libs/libXcomposite
	  x11-libs/libXcursor
	  x11-libs/libXdamage
	  x11-libs/libXext
	  x11-libs/libXfixes
	  x11-libs/libXi
	  x11-libs/libXrandr
	  xinerama? ( x11-libs/libXinerama )
	)
	
"
BDEPEND="app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/gobject-introspection-common
	dev-libs/libxslt
	>=dev-util/gdbus-codegen-2.48
	dev-util/glib-utils
	dev-util/gtk-doc-am
	wayland? ( dev-util/wayland-scanner )
	sys-devel/gettext
	virtual/pkgconfig
	x11-libs/gdk-pixbuf
	gtk-doc? (
	  app-text/docbook-xml-dtd:4.3
	  dev-util/gtk-doc
	)
	
"
RDEPEND="${CDEPEND}
	dev-util/gtk-update-icon-cache
	
"
DEPEND="${CDEPEND}
	sysprof? ( dev-util/sysprof )
	X? ( x11-base/xorg-proto )
	
"
PDEPEND="gnome-base/librsvg
	x11-themes/adwaita-icon-theme
	vim-syntax? ( app-vim/gtk-syntax )
	
"
S="${WORKDIR}/gtk-3.24.51"
src_prepare() {
	default
	# Force sysprof-capture-4 instead of checking sysprof-capture-3 first; either is
	# fine as far as deps are concerned, as it static links, but sysprof-capture-3
	# links to glib which would be done statically if there's glib[static-libs],
	# making the whole of gtk+ static link to glib instead of dynamic linking to glib.
	sed -i -e "s/'sysprof-capture-3'/'sysprof-capture-4'/g" meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Dquartz_backend=false
	  $(meson_use broadway broadway_backend)
	  $(meson_use cloudproviders)
	  $(meson_use examples demos)
	  $(meson_use examples)
	  -Dgtk_doc=$(usex gtk-doc true false)
	  -Dintrospection=$(usex introspection true false)
	  $(meson_use sysprof profiler)
	  $(meson_use wayland wayland_backend)
	  $(meson_use X x11_backend)
	  -Dcolord=$(usex colord yes no)
	  -Dprint_backends=$(usex cups cups,file,lpr file,lpr)
	  -Dxinerama=$(usex xinerama yes no)
	  # Include backend immodules into gtk itself, to avoid problems like
	  # https://gitlab.gnome.org/GNOME/gnome-shell/issues/109 from a
	  # user overridden GTK_IM_MODULE envvar
	  -Dbuiltin_immodules=backend
	  -Dman=true
	  -Dtests=false
	  -Dtracker3=false
	)
	meson_src_configure
}
src_install_all() {
	meson_src_install
	insinto /etc/gtk-3.0
	doins "${FILESDIR}"/settings.ini
	# Skip README.win32.md that would get installed by default
	DOCS=( NEWS README.md )
	einstalldocs
}
pkg_preinst() {
	gnome3_pkg_preinst
	# Make immodules.cache belongs to gtk+ alone
	local cache="/usr/$(get_libdir)/gtk-3.0/3.0.0/immodules.cache"
	if [[ -e ${EROOT}${cache} ]]; then
	  cp "${EROOT}${cache}" "${ED}${cache}" || die
	else
	  touch "${ED}${cache}" || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
	  rm -f "${EROOT}/usr/$(get_libdir)/gtk-3.0/3.0.0/immodules.cache"
	fi
}


# vim: filetype=ebuild
