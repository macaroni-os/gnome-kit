# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Build infrastructure for packages that use Vala"
HOMEPAGE="https://wiki.gnome.org/Projects/Vala"
SRC_URI="https://download.gnome.org/sources/vala/0.56/vala-0.56.18.tar.xz -> vala-0.56.18.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/vala-0.56.18"
src_configure() { :; }
src_compile() { :; }
src_install() {
	  insinto /usr/share/aclocal
	  doins vala.m4 vapigen/vapigen.m4
	  insinto /usr/share/vala
	  doins vapigen/Makefile.vapigen
}


# vim: filetype=ebuild
