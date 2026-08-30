# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
VALA_USE_DEPEND="vapigen"
inherit flag-o-matic meson python-any-r1 vala gnome3

DESCRIPTION="Library providing a virtual terminal emulator widget"
HOMEPAGE="https://gitlab.gnome.org/GNOME/vte"
SRC_URI="https://download.gnome.org/sources/vte/0.82/vte-0.82.4.tar.xz -> vte-0.82.4.tar.xz"
LICENSE="LGPL-3+ GPL-3+"
SLOT="2.91"
KEYWORDS="*"
IUSE="+crypt debug +glade gtk-doc icu +introspection elogind systemd +vala gtk4"
REQUIRED_USE="gtk-doc? ( introspection )
vala? ( introspection )
"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	
"
RDEPEND="app-arch/lz4
	dev-libs/glib:2
	dev-libs/libpcre2
	x11-libs/gtk+:3[introspection?]
	dev-libs/fribidi
	x11-libs/pango
	sys-libs/zlib
	gtk4? ( x11-libs/gtk:4[introspection?] )
	elogind? ( sys-auth/elogind )
	crypt? ( net-libs/gnutls:0= )
	glade? ( dev-util/glade:3.10 )
	introspection? ( dev-libs/gobject-introspection:= )
	x11-libs/pango[introspection?]
	
"
DEPEND="${RDEPEND}
	dev-util/gperf
	dev-libs/libxml2:2
	gtk-doc? (
	  dev-util/gtk-doc
	  dev-util/gtk-doc-am
	)
	dev-util/intltool
	sys-devel/gettext
	vala? ( $(vala_depend) )
	
"
src_prepare() {
	default
	use vala && vala_src_prepare
	xdg_environment_reset
	# -Ddebug option enables various debug support via VTE_DEBUG, but also ggdb3; strip the latter
	sed -e '/ggdb3/d' -i meson.build || die
	sed -i 's/vte_gettext_domain = vte_api_name/vte_gettext_domain = vte_gtk3_api_name/' meson.build || die
}
src_configure() {
	# Upstream don't support LTO & error out on it in meson.build
	filter-lto
	local emesonargs=(
	  -Da11y=true
	  $(meson_use debug)
	  $(meson_use gtk-doc docs)
	  $(meson_use introspection gir)
	  -Dfribidi=true # pulled in by pango anyhow
	  -Dgtk3=true
	  $(meson_use crypt gnutls)
	  $(meson_use gtk4)
	  $(meson_use icu)
	  $(meson_use glade)
	  $(meson_use systemd _systemd)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use systemd; then
	  rm "${ED}"/usr/lib/systemd/user/vte-spawn-.scope.d/defaults.conf || die
	fi
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/ || die
	  mv "${ED}"/usr/share/doc/vte-${SLOT} "${ED}"/usr/share/gtk-doc/vte-${SLOT}-gtk3 || die
	fi
	mv "${ED}"/etc/profile.d/vte{,-${SLOT}}.sh || die
}


# vim: filetype=ebuild
