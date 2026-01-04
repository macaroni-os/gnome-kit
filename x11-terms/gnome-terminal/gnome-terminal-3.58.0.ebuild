# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic gnome3 meson python-any-r1

DESCRIPTION="A terminal emulator for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-terminal"
SRC_URI="https://download.gnome.org/sources/gnome-terminal/3.58/gnome-terminal-3.58.0.tar.xz -> gnome-terminal-3.58.0.tar.xz"
LICENSE="GPL-3+ GPL-3 CC-BY-SA-3.0 FDL-1.3"
SLOT="0"
KEYWORDS="*"
IUSE="X debug gnome-shell nautilus"
BDEPEND="${PYTHON_DEPS}
	dev-libs/libxml2
	dev-libs/libxslt
	dev-util/gdbus-codegen
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:3[X?]
	dev-libs/libhandy
	x11-libs/vte
	dev-libs/libpcre2
	gnome-base/gsettings-desktop-schemas
	sys-apps/util-linux
	gnome-shell? ( gnome-base/gnome-shell )
	nautilus? ( gnome-base/nautilus )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	# Drop vte subproject. We use our package
	# with elogind patch.
	default
	rm -rf subprojects/vte || die
}
src_configure() {
	# Upstream don't support LTO
	filter-lto
	local emesonargs=(
	  -Ddocs=false
	  $(meson_use debug dbg)
	  $(meson_use nautilus nautilus_extension)
	  $(meson_use gnome-shell search_provider)
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
