# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala

DESCRIPTION=""
SRC_URI="https://download.gnome.org/sources/libcloudproviders/0.3/libcloudproviders-0.3.6.tar.xz -> libcloudproviders-0.3.6.tar.xz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection vala"
REQUIRED_USE="vala? ( introspection )"
BDEPEND="dev-util/gdbus-codegen
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dinstalled-tests=false
	  -Dintrospection=$(usex introspection true false)
	  -Dvapigen=$(usex vala true false)
	  -Denable-gtk-doc=$(usex gtk-doc true false)
	)
	meson_src_configure
}


# vim: filetype=ebuild
