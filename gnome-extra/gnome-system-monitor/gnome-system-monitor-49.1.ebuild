# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson flag-o-matic

DESCRIPTION="Gnome System Monitor"
HOMEPAGE="https://apps.gnome.org/SystemMonitor/"
SRC_URI="https://download.gnome.org/sources/gnome-system-monitor/49/gnome-system-monitor-49.1.tar.xz -> gnome-system-monitor-49.1.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
BDEPEND="dev-cpp/catch
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	sys-auth/polkit
	
"
RDEPEND="dev-cpp/glibmm:2.68
	dev-cpp/gtkmm:4.0
	dev-libs/glib:2
	x11-libs/gtk:4
	gnome-base/libgtop:=
	x11-libs/libadwaita
	gnome-base/librsvg
	systemd? ( sys-apps/systemd:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	# Drop test units fails for linking with catch
	sed -e '/test\/cgroups.cpp/d' -e '/test\/join.cpp/d' -i src/meson.build
}
src_configure() {
	local emesonargs=(
	  $(meson_use systemd)
	  -Ddevelopment=false
	  --wrap-mode nodownload
	  --libdir lib64
	  --localstatedir /var/lib
	  --prefix /usr
	  --sysconfdir /etc
	)
	# meson_src_configure breaks compilation. Override it.
	einfo "meson setup "${S}"-build ${emesonargs[@]}"
	export BUILD_DIR="${BUILD_DIR:-${WORKDIR}/${P}-build}"
	meson setup ${BUILD_DIR} ${emesonargs[@]}
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
