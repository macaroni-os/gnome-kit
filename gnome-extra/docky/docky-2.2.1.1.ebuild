# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils gnome3 mono-env

DESCRIPTION="Elegant, powerful, clean dock"
HOMEPAGE="https://wiki.go-docky.com"
SRC_URI="https://launchpad.net/${PN}/2.2/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="debug nls"

RDEPEND=">=dev-dotnet/dbus-sharp-0.8.0:2.0
	>=dev-dotnet/dbus-sharp-glib-0.6.0:2.0
	|| ( >=dev-dotnet/gnome-sharp-2.24.2-r1:2 dev-dotnet/gconf-sharp:2 )
	>=dev-dotnet/gio-sharp-0.2-r1
	|| ( >=dev-dotnet/gtk-sharp-2.12.21:2 dev-dotnet/glib-sharp:2 )
	dev-dotnet/gkeyfile-sharp
	dev-dotnet/gnome-desktop-sharp:2
	dev-dotnet/gnome-keyring-sharp
	dev-dotnet/gtk-sharp:2
	dev-dotnet/mono-addins[gtk]
	dev-dotnet/notify-sharp
	dev-dotnet/rsvg-sharp:2
	dev-dotnet/wnck-sharp:2"
DEPEND="${RDEPEND}
	|| ( >=dev-dotnet/gtk-sharp-2.12.21:2 dev-dotnet/gtk-sharp-gapi:2 )
	dev-util/intltool
	virtual/pkgconfig"

DOCS="AUTHORS NEWS"

src_prepare() {
	default
	sed -i -e "/warnaserror/d" configure.ac || die
	eautoreconf
}

src_configure() {
	gnome3_src_configure \
		--enable-release \
		$(use_enable nls)
}
