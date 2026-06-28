# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit cargo meson

DESCRIPTION="Loaders for glycin clients (glycin crate or libglycin)"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin/"
SRC_URI="
https://gitlab.gnome.org/GNOME/glycin/-/archive/2.1.5/glycin-2.1.5.tar.bz2 -> glycin-loaders-2.1.5.tar.bz2
mirror://macaroni/glycin-loaders-2.1.5-mark-rust-bundle.tar.xz -> glycin-loaders-2.1.5-mark-rust-bundle.tar.xz"
LICENSE="|| ( LGPL-2.1+ MPL-2.0 )
Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+ IJG ISC
LGPL-3+ MIT Unicode-3.0
|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="2"
KEYWORDS="*"
IUSE="heif jpeg2k jpegxl svg debug"
RDEPEND="dev-libs/glib:2
	sys-libs/libseccomp
	heif? ( >=media-libs/libheif-1.17.0:= )
	
"
DEPEND="${RDEPEND}
"
PDEPEND="jpegxl? ( media-libs/libjxl:= )
	svg? (
	  gnome-base/librsvg:2
	  x11-libs/cairo
	)
	
"
S="${WORKDIR}/glycin-2.1.5"
src_unpack() {
	cargo_src_unpack
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
	  -Dglycin-loaders=true
	  -Dloaders="${formats_s// /,}"
	  -Dtests=false
	  -Dlibglycin=false
	  -Dlibglycin-gtk4=false
	  -Dglycin-thumbnailer=false
	)
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}


# vim: filetype=ebuild
