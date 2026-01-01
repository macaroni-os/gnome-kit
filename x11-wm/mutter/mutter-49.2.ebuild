# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 flag-o-matic meson python-any-r1 udev

DESCRIPTION="GNOME compositing window manager based on Clutter"
HOMEPAGE="https://mutter.gnome.org"
SRC_URI="https://download.gnome.org/sources/mutter/49/mutter-49.2.tar.xz -> mutter-49.2.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="bash-completion debug elogind gnome gtk-doc input_devices_wacom
+introspection screencast sysprof systemd udev wayland X xwayland
video_cards_nvidia
"
REQUIRED_USE="|| ( X wayland )
gtk-doc? ( introspection )
wayland? ( ^^ ( elogind systemd ) udev )
xwayland? ( X )
"
BDEPEND="dev-util/wayland-scanner
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	wayland? (
	  sys-kernel/linux-headers
	  x11-libs/libxcvt
	)
	bash-completion? (
	  app-shells/bash-completion
	  ${PYTHON_DEPS}
	  dev-python/argcomplete
	)
	
"
RDEPEND=">=media-libs/graphene-1.10.2[introspection?]
	x11-libs/gdk-pixbuf
	x11-libs/pango[introspection?]
	x11-libs/cairo[X]
	x11-libs/pixman
	dev-libs/fribidi
	gnome-base/gsettings-desktop-schemas[introspection?]
	dev-libs/glib:2
	gnome-base/gnome-settings-daemon
	x11-libs/libxkbcommon[X?]
	app-accessibility/at-spi2-core[introspection?]
	sys-apps/dbus
	x11-misc/colord:=
	media-libs/lcms
	media-libs/harfbuzz:=
	dev-libs/libei
	media-libs/libdisplay-info:=
	gnome? ( gnome-base/gnome-desktop:= )
	media-libs/libcanberra
	media-libs/libglvnd
	media-libs/libglycin
	dev-libs/wayland
	wayland? (
	  dev-libs/wayland-protocols
	  x11-libs/libdrm
	  media-libs/mesa[gbm(+)]
	  dev-libs/libinput:=
	  elogind? ( sys-auth/elogind )
	  xwayland? ( x11-base/xwayland )
	  video_cards_nvidia? ( gui-libs/egl-wayland )
	)
	udev? (
	  virtual/libudev:=
	  dev-libs/libgudev
	)
	systemd? ( sys-apps/systemd )
	input_devices_wacom? ( dev-libs/libwacom:= )
	screencast? ( media-video/pipewire:= )
	introspection? ( dev-libs/gobject-introspection:= )
	sysprof? ( dev-util/sysprof )
	X? (
	  x11-libs/gtk:4[X,introspection?]
	  media-libs/libglvnd[X]
	  x11-libs/libX11
	  x11-libs/libXcomposite
	  x11-libs/libXcursor
	  x11-libs/libXdamage
	  x11-libs/libXext
	  x11-libs/libXfixes
	  x11-libs/libXi
	  x11-misc/xkeyboard-config
	  x11-libs/libXrandr
	  x11-libs/libxcb:=
	  x11-libs/libXinerama
	  x11-libs/libXau
	  x11-libs/startup-notification
	  x11-libs/libICE
	  x11-libs/libxkbfile
	  x11-libs/libXtst
	  x11-libs/libSM
	)
	
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	sysprof? ( dev-util/sysprof )
	
"
src_configure() {
	use debug && EMESON_BUILDTYPE=debug
	local emesonargs=(
	  -Dopengl=true
	  -Degl=true
	  -Dfonts=true
	  $(meson_use wayland gles2)
	  $(meson_use X glx)
	  $(meson_use wayland)
	)
	if use wayland; then
	  emesonargs+=(
	    $(meson_use xwayland)
	  )
	else
	  emesonargs+=(
	    -Dxwayland=false
	  )
	fi
	if use elogind || use systemd; then
	  emesonargs+=(
	    -Dlogind=true
	  )
	fi
	emesonargs+=(
	  $(meson_use wayland native_backend)
	  $(meson_use screencast remote_desktop)
	  $(meson_use gnome libgnome_desktop)
	  $(meson_use udev)
	  -Dudev_dir=$(get_udevdir)
	  $(meson_use input_devices_wacom libwacom)
	  -Dsound_player=true
	  -Dstartup_notification=true
	  $(meson_use introspection)
	  $(meson_use gtk-doc docs)
	  -Dcogl_tests=false
	  -Dclutter_tests=false
	  -Dmutter_tests=false
	  -Dtests=disabled
	  -Dkvm_tests=false
	  -Dtty_tests=false
	  $(meson_use sysprof profiler)
	  -Dinstalled_tests=false
	  $(meson_use X x11)
	  $(meson_use bash-completion bash_completion)
	)
	if use wayland && use video_cards_nvidia; then
	  emesonargs+=(
	    -Degl_device=true
	    -Dwayland_eglstream=true
	  )
	else
	  # It seems that -ldl is only
	  # loaded with wayland_eglstream
	  append-ldflags "-ldl"
	  emesonargs+=(
	    -Degl_device=false
	    -Dwayland_eglstream=false
	  )
	fi
	meson_src_configure
}
pkg_postinst() {
	use udev && udev_reload
	gnome3_pkg_postinst
}
pkg_postrm() {
	use udev && udev_reload
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
