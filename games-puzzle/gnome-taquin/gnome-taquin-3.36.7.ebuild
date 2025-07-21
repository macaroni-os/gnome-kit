# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit gnome3 vala meson

DESCRIPTION="Move tiles so that they reach their places"
HOMEPAGE="https://wiki.gnome.org/Apps/Taquin"

LICENSE="GPL-3+ CC-BY-SA-3.0 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="*"

IUSE=""

RDEPEND="
	>=dev-libs/glib-2.62.2:2
	>=gnome-base/librsvg-2.32:2
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/gtk+-3.24.12:3
	media-libs/gsound
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	dev-libs/appstream-glib
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/taquin_66be44dc20d114e449fc33156e3939fd05dfbb16.patch
	"${FILESDIR}"/taquin_99dea5e7863e112f33f16e59898c56a4f1a547b3.patch
)

src_prepare() {
	gnome3_src_prepare
	vala_src_prepare
}
