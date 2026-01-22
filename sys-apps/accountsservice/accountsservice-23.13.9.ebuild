# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 systemd vala

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/AccountsService/"
SRC_URI="https://www.freedesktop.org/software/accountsservice/accountsservice-23.13.9.tar.xz -> accountsservice-23.13.9.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="doc elogind gtk-doc +introspection systemd vala"
REQUIRED_USE="^^ ( elogind systemd )
"
BDEPEND="dev-util/gdbus-codegen
	dev-util/gtk-doc-am
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
	  app-text/docbook-xml-dtd:4.1.2
	  app-text/xmlto
	)
	
"
RDEPEND="dev-libs/glib:2
	sys-auth/polkit
	elogind? ( sys-auth/elogind )
	introspection? ( dev-libs/gobject-introspection:= )
	systemd? ( sys-apps/systemd:= )
	
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
}
src_configure() {
	sed -e "/subdir('tests')/d" -i meson.build || die
	local emesonargs=(
	  --localstatedir="${EPREFIX}/var"
	  -Dsystemdsystemunitdir="$(systemd_get_systemunitdir)"
	  -Dadmin_group="wheel"
	  $(meson_use elogind)
	  $(meson_use introspection)
	  $(meson_use doc docbook)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# https://gitlab.freedesktop.org/accountsservice/accountsservice/-/issues/90
	if use doc; then
	  mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die
	fi
	# This directories are created at runtime when needed
	rm -r "${ED}"/var/lib || die
}


# vim: filetype=ebuild
