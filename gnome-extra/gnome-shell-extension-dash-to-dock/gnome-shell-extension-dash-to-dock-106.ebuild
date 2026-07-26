# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3-utils

DESCRIPTION="A dock for the Gnome Shell. This extension   moves the dash out of the overview transforming it in a dock for an easier   launching of applications and a faster switching between windows and desktops."
HOMEPAGE="https://micheleg.github.io/dash-to-dock/"
SRC_URI="https://api.github.com/repos/micheleg/dash-to-dock/tarball/refs/tags/extensions.gnome.org-v106 -> gnome-shell-extension-dash-to-dock-106-a7b1981.tar.gz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-util/intltool
	sys-devel/gettext
	
"
RDEPEND="dev-libs/glib:2
	app-eselect/eselect-gnome-shell-extensions
	gnome-base/gnome-shell
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv micheleg-dash-to-dock-* ${S}
}


src_prepare() {
	default
	# Set correct version
	export VERSION="${PV}"
	# Don't install README and COPYING in unwanted locations
	sed -i -e 's/COPYING//g' -e 's/README.md//g' Makefile || die
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
