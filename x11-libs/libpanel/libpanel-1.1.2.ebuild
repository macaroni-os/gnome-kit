# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala xdg

DESCRIPTION="A dock/panel library for GTK 4"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libpanel"
SRC_URI="https://download.gnome.org/sources/libpanel/1.1/libpanel-1.1.2.tar.xz -> libpanel-1.1.2.tar.xz"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="examples gtk-doc +introspection +vala"
REQUIRED_USE="gtk-doc? ( introspection )
vala? ( introspection )
"
BDEPEND="gtk-doc? ( dev-util/gi-docgen )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4[introspection?]
	x11-libs/libadwaita:1
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  $(meson_use examples install-examples)
	  $(meson_feature introspection)
	  $(meson_feature gtk-doc docs)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir "${ED}"/usr/share/gtk-doc || die
	  mv "${ED}"/usr/share/doc/panel-1.0 "${ED}"/usr/share/gtk-doc/ || die
	fi
}


# vim: filetype=ebuild
