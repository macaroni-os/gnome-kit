# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 vala xdg

DESCRIPTION="Building blocks for modern GNOME applications"
HOMEPAGE="https://gnome.pages.gitlab.gnome.org/libadwaita/ https://gitlab.gnome.org/GNOME/libadwaita"
SRC_URI="https://download.gnome.org/sources/libadwaita/1.8/libadwaita-1.8.5.1.tar.xz -> libadwaita-1.8.5.1.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="doc +introspection +vala"
REQUIRED_USE="doc? ( introspection )
vala? ( introspection )
"
BDEPEND="${PYTHON_DEPS}
	doc? ( dev-util/gi-docgen )
	vala? ( $(vala_depend) )
	sys-devel/gettext
	virtual/pkgconfig
	dev-lang/sassc
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4[introspection?]
	dev-libs/appstream:=
	dev-libs/fribidi
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  # Never use gi-docgen subproject
	  --wrap-mode nofallback
	  -Dprofiling=false
	  $(meson_feature introspection)
	  $(meson_use vala vapi)
	  $(meson_use doc documentation)
	  -Dtests=false
	  -Dexamples=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use doc; then
	  mv "${ED}"/usr/share/doc/{${PN}-${SLOT},${PF}/html} || die
	fi
}


# vim: filetype=ebuild
