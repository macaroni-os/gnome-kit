# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EXTENSION_NAME=transparent-top-bar@ftpix.com
inherit gnome3-utils

DESCRIPTION=""
HOMEPAGE="https://github.com/lamarios/gnome-shell-extension-transparent-top-bar"
SRC_URI="https://extensions.gnome.org/extension-data/transparent-top-barftpix.com.v26.shell-extension.zip -> gnome-shell-extension-transparent-topbar-26.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/glib:2
	app-eselect/eselect-gnome-shell-extensions
	gnome-base/gnome-shell
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/transparent-top-bar-26"
src_unpack() {
	local myp="transparent-top-bar-26"
	cd ${WORKDIR}
	mkdir ${myp}
	cd ${myp}
	unpack ${A}
}
src_install() {
	local extdir=/usr/share/gnome-shell/extensions/
	dodir ${extdir}/${EXTENSION_NAME}
	for i in * ; do
	  cp -r ${S}/${i} ${D}/${extdir}/${EXTENSION_NAME}/
	done
}
pkg_preinst() {
	gnome3_schemas_savelist
}
pkg_postinst() {
	gnome3_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}
pkg_postrm() {
	gnome3_schemas_update
}


# vim: filetype=ebuild
