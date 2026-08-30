# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
USE_RUBY="ruby31 ruby32 ruby33 ruby34"
inherit flag-o-matic gnome3 python-any-r1 ruby-single toolchain-funcs cmake

DESCRIPTION="Open source web browser engine"
HOMEPAGE="https://www.webkitgtk.org"
SRC_URI="https://www.webkitgtk.org/releases/webkitgtk-2.50.6.tar.xz -> webkitgtk-2.50.6.tar.xz"
LICENSE="LGPL-2+ BSD"
SLOT="6"
KEYWORDS="*"
IUSE="avif examples gamepad keyring +gstreamer +introspection
pdf jpegxl +jumbo-build lcms seccomp spell systemd
wayland X
"
REQUIRED_USE="|| ( wayland X )
"
BDEPEND="${PYTHON_DEPS}
	${RUBY_DEPS}
	app-accessibility/at-spi2-core
	dev-lang/perl
	dev-util/gdbus-codegen
	dev-util/gperf
	dev-util/unifdef
	sys-devel/bison
	sys-devel/gettext
	virtual/pkgconfig
	wayland? ( dev-util/wayland-scanner )
	
"
RDEPEND="app-accessibility/at-spi2-core:2
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libgcrypt:0=
	dev-libs/libtasn1:=
	dev-libs/libxml2:2=
	dev-libs/libxslt
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/harfbuzz:=[icu(+)]
	media-libs/libjpeg-turbo:0=
	media-libs/libepoxy[egl(+)]
	media-libs/libglvnd
	media-libs/libpng:0=
	media-libs/libwebp:=
	media-libs/mesa
	media-libs/woff2
	media-libs/svt-av1
	net-libs/libsoup:3[introspection?]
	dev-libs/libzip:=
	x11-libs/cairo[X?]
	x11-libs/libdrm
	avif? ( media-libs/libavif:= )
	gamepad? ( dev-libs/libmanette )
	gstreamer? (
	  media-libs/gstreamer:1.0
	  media-libs/gst-plugins-base:1.0[egl,opengl,opus,X?]
	  media-libs/gst-plugins-bad:1.0
	)
	introspection? ( dev-libs/gobject-introspection:= )
	jpegxl? ( media-libs/libjxl:= )
	keyring? ( app-crypt/libsecret )
	lcms? ( media-libs/lcms:2 )
	seccomp? (
	  sys-apps/bubblewrap
	  sys-libs/libseccomp
	  sys-apps/xdg-dbus-proxy
	)
	spell? ( app-text/enchant:2 )
	systemd? ( sys-apps/systemd:= )
	X? ( x11-libs/libX11 )
	wayland? (
	  dev-libs/wayland
	  dev-libs/wayland-protocols
	)
	x11-libs/gtk:4[introspection?,wayland?,X?]
	x11-libs/gtk:4
	
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/webkitgtk-2.50.6"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_prepare() {
	cmake_src_prepare
	gnome3_src_prepare
	# We don't want -Werror for gobject-introspection (bug #947761)
	sed -i -e "s:--warn-error::" Source/cmake/FindGI.cmake || die
}
src_configure() {
	# Respect CC, otherwise fails on prefix #395875
	tc-export CC
	filter-lto
	local rubyimpl
	local ruby_interpreter=""
	local RUBY
	for rubyimpl in ${USE_RUBY}; do
	  if has_version -b "virtual/rubygems[ruby_targets_${rubyimpl}(-)]"; then
	    RUBY="$(type -P ${rubyimpl})"
	    ruby_interpreter="-DRUBY_EXECUTABLE=${RUBY}"
	  fi
	done
	[[ -z ${ruby_interpreter} ]] && die "No suitable ruby interpreter found"
	sed -i -e "s:#!/usr/bin/env ruby:#!${RUBY}:" $(grep -rl "/usr/bin/env ruby" Source/JavaScriptCore || die) || die
	local mycmakeargs=(
	  -DPython_EXECUTABLE="${PYTHON}"
	  ${ruby_interpreter}
	  -DBWRAP_EXECUTABLE:FILEPATH="${EPREFIX}"/usr/bin/bwrap
	  -DDBUS_PROXY_EXECUTABLE:FILEPATH="${EPREFIX}"/usr/bin/xdg-dbus-proxy
	  -DPORT=GTK
	  # Source/cmake/WebKitFeatures.cmake
	  -DENABLE_API_TESTS=OFF
	  -DENABLE_BUBBLEWRAP_SANDBOX=$(usex seccomp)
	  -DENABLE_DRAG_SUPPORT=ON
	  -DENABLE_GAMEPAD=$(usex gamepad)
	  -DENABLE_GEOLOCATION=ON # Runtime optional (talks over dbus service)
	  -DENABLE_MINIBROWSER=$(usex examples)
	  -DENABLE_PDFJS=$(usex pdf)
	  -DENABLE_SPEECH_SYNTHESIS=OFF
	  -DENABLE_SPELLCHECK=$(usex spell)
	  -DENABLE_TOUCH_EVENTS=ON
	  -DENABLE_UNIFIED_BUILDS=$(usex jumbo-build)
	  -DENABLE_VIDEO=$(usex gstreamer)
	  -DENABLE_WEB_AUDIO=$(usex gstreamer)
	  -DENABLE_WEB_CODECS=$(usex gstreamer) # https://bugs.webkit.org/show_bug.cgi?id=269147
	  -DENABLE_WEBDRIVER=ON
	  -DENABLE_WEBGL=ON
	  -DUSE_AVIF=$(usex avif)
	  # Source/cmake/GStreamerDependencies.cmake
	  -DENABLE_MEDIA_TELEMETRY=OFF
	  -DUSE_GSTREAMER_WEBRTC=$(usex gstreamer)
	  # Source/cmake/OptionsGTK.cmake
	  -DENABLE_DOCUMENTATION=OFF
	  -DENABLE_INTROSPECTION=$(usex introspection)
	  -DENABLE_JOURNALD_LOG=$(usex systemd)
	  -DENABLE_QUARTZ_TARGET=OFF
	  -DENABLE_WAYLAND_TARGET=$(usex wayland)
	  -DENABLE_X11_TARGET=$(usex X)
	  -DUSE_GBM=ON
	  -DUSE_JPEGXL=$(usex jpegxl)
	  -DUSE_LCMS=$(usex lcms)
	  -DUSE_LIBBACKTRACE=OFF
	  -DUSE_LIBDRM=ON
	  -DUSE_LIBHYPHEN=ON
	  -DUSE_LIBSECRET=$(usex keyring)
	  -DUSE_SOUP2=OFF
	  -DUSE_SYSPROF_CAPTURE=OFF
	  -DUSE_WOFF2=ON
	  -DUSE_GTK4=ON # webkit2gtk-6.0
	 )
	append-cppflags -DNDEBUG
	WK_USE_CCACHE=NO cmake_src_configure
}
src_install() {
	cmake_src_install
	insinto /usr/share/gtk-doc/html
	doins -r "${S}"/Documentation/{jsc-glib,webkitgtk,webkitgtk-web-process-extension}-6.0
}



# vim: filetype=ebuild
