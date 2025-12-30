# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 systemd udev xdg

DESCRIPTION="Graphical user interface for CUPS administration"
HOMEPAGE="https://github.com/OpenPrinting/system-config-printer"
SRC_URI="https://github.com/OpenPrinting/system-config-printer/releases/download/v1.5.18/system-config-printer-1.5.18.tar.xz -> system-config-printer-1.5.18.tar.xz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/system-config-printer-1.5.18-fix-debugprint-exception.patch"
)
IUSE="gnome-keyring policykit"
# Commons depends
CDEPEND="dev-libs/glib:2
	net-print/cups[dbus]
	virtual/libusb:1
	virtual/udev
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
	
"
RDEPEND="${CDEPEND}
	$(python_gen_cond_dep '
	  dev-python/dbus-python[${PYTHON_USEDEP}]
	  dev-python/pycairo[${PYTHON_USEDEP}]
	  dev-python/pycups[${PYTHON_USEDEP}]
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	  dev-python/requests[${PYTHON_USEDEP}]
	  dev-python/urllib3[${PYTHON_USEDEP}]
	')
	gnome-keyring? ( app-crypt/libsecret[introspection] )
	policykit? ( net-print/cups-pk-helper )
	
"
DEPEND="${CDEPEND}
"
BDEPEND="app-text/xmlto
"
src_configure() {
	local myeconfargs=(
	  --with-xmlto
	  --enable-nls
	  --with-desktop-vendor=MacaroniOS
	  --with-udev-rules
	  --with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
	)
	econf "${myeconfargs[@]}"
}
src_compile() {
	emake PYTHON=:
	distutils-r1_src_compile
}
src_install() {
	emake DESTDIR="${D}" PYTHON=: install
	python_fix_shebang "${ED}"
	distutils-r1_src_install
}
pkg_postinst() {
	udev_reload
}
pkg_postrm() {
	udev_reload
}


# vim: filetype=ebuild
