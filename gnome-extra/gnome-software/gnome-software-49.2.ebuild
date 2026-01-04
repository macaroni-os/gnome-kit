# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="Gnome install & update software"
HOMEPAGE="https://wiki.gnome.org/Apps/Software"
SRC_URI="https://download.gnome.org/sources/gnome-software/49/gnome-software-49.2.tar.xz -> gnome-software-49.2.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="dkms +firmware +flatpak gnome gtk-doc sysprof spell udev"
BDEPEND="dev-libs/libxml2
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/appstream:=
	x11-libs/gdk-pixbuf
	dev-libs/libxmlb:=
	x11-libs/gtk:4
	dev-libs/glib:2
	dev-libs/json-glib
	net-libs/libsoup:3
	x11-libs/libadwaita
	sysprof? ( dev-util/sysprof )
	gnome-base/gsettings-desktop-schemas
	sys-auth/polkit
	firmware? ( sys-apps/fwupd )
	flatpak? (
	  sys-apps/flatpak
	  sys-fs/libostree
	)
	udev? ( dev-libs/libgudev )
	gnome-base/gsettings-desktop-schemas
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	xdg_src_prepare
	sed -i -e '/install_data.*README\.md.*share\/doc\/gnome-software/d' meson.build || die
	# We don't need language packs download support, and it fails tests in 3.34.2 for us (if they are enabled)
	sed -i -e '/subdir.*fedora-langpacks/d' plugins/meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Dtests=false
	  -Dman=true
	  -Dpackagekit=false
	  -Deos_updater=false # Endless OS update
	  -Dopensuse-distro-upgrade=false
	  # -Dpackagekit_autoremove
	  -Dpolkit=true
	  -Dmalcontent=false
	  -Drpm_ostree=false
	  -Dwebapps=true
	  -Ddefault_featured_apps=true
	  -Dhardcoded_curated=true
	  -Dhardcoded_foss_webapps=true
	  -Dhardcoded_proprietary_webapps=true
	  -Dapt=false
	  -Dexternal_appstream=false
	  -Dhardcoded_curated=true
	  # TODO: Will this be beneficial to us with flatpak at least? If
	  # enabled, it shows some apps under installed (probably merely due to
	  # /usr/share/app-info presence), but launching and removal of them is
	  # broken
	  -Ddefault_featured_apps=false
	  -Dmogwai=false #TODO?
	  -Dprofile=''
	  -Dsnap=false
	  -Dopensuse-distro-upgrade=false
	  $(meson_use dkms)
	  $(meson_use firmware fwupd)
	  $(meson_use flatpak)
	  $(meson_use udev gudev)
	  $(meson_feature sysprof)
	  $(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
