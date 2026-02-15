# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit cargo meson vala

DESCRIPTION="Glycin C-Bindings for the library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin/"
SRC_URI="
https://gitlab.gnome.org/GNOME/glycin/-/archive/2.0.8/glycin-2.0.8.tar.bz2 -> libglycin-2.0.8.tar.bz2
mirror://macaroni/libglycin-2.0.8-mark-rust-bundle.tar.xz -> libglycin-2.0.8-mark-rust-bundle.tar.xz"
LICENSE="|| ( LGPL-2.1+ MPL-2.0 )
Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+ IJG ISC
LGPL-3+ MIT Unicode-3.0
|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="2"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/bump-rustix-libc-crate.patch"
	"${FILESDIR}/glycin-glibc-2.33.patch"
)
IUSE="heif jpeg2k jpegxl svg debug +vala"
RDEPEND="dev-libs/glib:2
	sys-libs/libseccomp
	heif? ( >=media-libs/libheif-1.17.0:= )
	jpegxl? ( media-libs/libjxl:= )
	svg? (
	  gnome-base/librsvg:2
	  x11-libs/cairo
	)
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/glycin-2.0.8"
src_unpack() {
	cargo_src_unpack
}
src_prepare() {
	use vala && vala_src_prepare
	default
	# Fix integration with py3.9
	sed -i -e 's|import tomllib|import tomli as tomllib|g' build-aux/crates-version.py || die
}
src_configure() {
	local formats=(
	  glycin-image-rs
	)
	if use heif ; then
	  formats+=( glycin-heif )
	fi
	if use jpeg2k ; then
	  formats+=( glycin-jpeg2000 )
	fi
	if use jpegxl ; then
	  formats+=( glycin-jxl )
	fi
	if use svg ; then
	  formats+=( glycin-svg )
	fi
	local formats_s=${formats[*]}
	local emesonargs=(
	  -Dprofile=$(usex debug dev release)
	  -Dglycin-loaders=false
	  -Dloaders="${formats_s// /,}"
	  -Dtests=false
	  -Dlibglycin=true
	  -Dlibglycin-gtk4=false
	  -Dglycin-thumbnailer=false
	)
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}


# vim: filetype=ebuild
