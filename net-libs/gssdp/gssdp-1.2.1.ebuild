# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
VALA_USE_DEPEND="vapigen"

inherit gnome2 vala meson

DESCRIPTION="A GObject-based API for handling resource discovery and announcement over SSDP"
HOMEPAGE="https://wiki.gnome.org/Projects/GUPnP"

LICENSE="LGPL-2"
SLOT="1.2"
KEYWORDS="*"
IUSE="doc examples +introspection gtk vala"

RDEPEND="
	>=dev-libs/glib-2.34.3:2
	>=net-libs/libsoup-2.44.2:2.4[introspection?]
	gtk? ( >=x11-libs/gtk+-3.0:3 )
	introspection? (
		$(vala_depend)
		>=dev-libs/gobject-introspection-1.36:= )
	!<net-libs/gupnp-vala-0.10.3
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.14
	sys-devel/gettext
	>=virtual/pkgconfig-0-r1
"

src_prepare() {
	use introspection && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	ECONF_SOURCE=${S} \
	local emesonargs=(
		$(meson_use introspection introspection)
		$(meson_use gtk sniffer)
		$(meson_use vala vapi)
		$(meson_use doc gtk_doc)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
}
