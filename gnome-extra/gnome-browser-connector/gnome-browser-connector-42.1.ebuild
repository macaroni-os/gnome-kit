# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1 xdg

DESCRIPTION="OS-native connector counterpart for GNOME Shell browser extension"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-browser-connector"
SRC_URI="https://download.gnome.org/sources/gnome-browser-connector/42/gnome-browser-connector-42.1.tar.xz -> gnome-browser-connector-42.1.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gnome-browser-connector-42.1-python-path.patch"
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]')
	gnome-base/gnome-shell
	!gnome-extra/chrome-gnome-shell
	
"
DEPEND="${RDEPEND}
"
src_install() {
	meson_src_install
	# fix shebang (python_fix_shebang doesn't work correctly for this).
	sed -i -e '1s:#!.*:#!/usr/bin/python:g' "${D}"/usr/bin/${PN}
	sed -i -e '1s:#!.*:#!/usr/bin/python:g' "${D}"/usr/bin/${PN}-host
	python_optimize
	# Macaroni OS uses split-user rootfs
	insinto /usr/lib/mozilla/native-messaging-hosts
	for id in chrome_gnome_shell browser_connector; do
	  doins "${ED}/usr/$(get_libdir)/mozilla/native-messaging-hosts/org.gnome.${id}.json"
	done
}
pkg_postinst() {
	xdg_pkg_postinst
	 elog "Please note that this package provides OS-native connector only."
	elog "You can install browser extension using link provided at"
	elog "https://extensions.gnome.org website."
}


# vim: filetype=ebuild
