# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1 vala

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://gitlab.gnome.org/GNOME/simple-scan"
SRC_URI="https://download.gnome.org/sources/simple-scan/49/simple-scan-49.1.tar.xz -> simple-scan-49.1.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/46.0-add-control-optional-deps.patch"
)
IUSE="colord webp"
BDEPEND="${PYTHON_DEPS}
	$(vala_depend)
	dev-libs/libxml2
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	x11-libs/libadwaita[vala]
	dev-libs/libgusb[vala]
	colord? ( x11-misc/colord[vala] )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	dev-libs/libgusb
	colord? ( x11-misc/colord:=[udev(+)] )
	webp? ( media-libs/libwebp:= )
	media-gfx/sane-backends
	x11-misc/xdg-utils
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	vala_src_prepare
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Dpackagekit=false
	  $(meson_use colord)
	  $(meson_use webp)
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
