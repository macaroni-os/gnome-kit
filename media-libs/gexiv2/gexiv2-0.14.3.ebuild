# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-r1 vala xdg-utils

DESCRIPTION="GObject-based wrapper around the Exiv2 library"
HOMEPAGE="https://wiki.gnome.org/Projects/gexiv2"
SRC_URI="https://download.gnome.org/sources/gexiv2/0.14/gexiv2-0.14.3.tar.xz -> gexiv2-0.14.3.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection python static-libs test +vala"
REQUIRED_USE="python? ( introspection ${PYTHON_REQUIRED_USE} )
test? ( python introspection )
vala? ( introspection )
"
RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	media-gfx/exiv2:0=
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	
"
src_prepare() {
	xdg_environment_reset
	use vala && vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	  # prevents installation of python modules (uses install_data from meson
	  # which does not optimize the modules
	  -Dpython3=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use python ; then
	  python_moduleinto gi/overrides/
	  python_foreach_impl python_domodule GExiv2.py
	fi
}


# vim: filetype=ebuild
