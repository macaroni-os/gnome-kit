# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1

DESCRIPTION="Graphical front-ends to various networking command-line"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-nettool"
SRC_URI="https://download.gnome.org/sources/gnome-nettool/42/gnome-nettool-42.0.tar.xz -> gnome-nettool-42.0.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
# Commons depends
CDEPEND="x11-libs/gtk+:3
	dev-libs/glib:2
	gnome-base/libgtop:=
	
"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	app-text/yelp-tools
	sys-devel/gettext
	
"
RDEPEND="${CDEPEND}
	|| (
	  net-misc/iputils
	  net-analyzer/tcptraceroute
	  net-analyzer/traceroute
	)
	net-analyzer/nmap
	net-dns/bind-tools
	net-misc/netkit-fingerd
	net-misc/whois
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	sed -i -e "s|('desktop',|(|g" \
	  -e "s|('appdata',|(|g" data/meson.build
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
