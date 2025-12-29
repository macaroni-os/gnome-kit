# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic gnome3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
SRC_URI="https://download.gnome.org/sources/gtk+/2.24/gtk%2B-2.24.33.tar.xz -> gtk+-2.24.33.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="cups examples +introspection vim-syntax xinerama"
# Commons depends
CDEPEND="app-accessibility/at-spi2-core[introspection?]
	dev-libs/glib:2
	media-libs/fontconfig
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2[introspection?]
	x11-libs/pango[introspection?]
	
	cups? ( net-print/cups:= )
	introspection? ( dev-libs/gobject-introspection:= )
	x11-libs/cairo[X]
	x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXfixes
	x11-libs/libXcomposite
	x11-libs/libXdamage
	xinerama? ( x11-libs/libXinerama )
	
"
RDEPEND="${CDEPEND}
	dev-util/gtk-update-icon-cache
	x11-themes/gnome-themes-standard
	
"
DEPEND="${CDEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xml-dtd:4.3
	dev-libs/libxslt
	dev-libs/gobject-introspection-common
	dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig
	
"
PDEPEND="gnome-base/librsvg
	x11-themes/adwaita-icon-theme
	x11-themes/gtk-engines-adwaita
	vim-syntax? ( app-vim/gtk-syntax )
	
"
strip_builddir() {
	local rule=$1
	shift
	local directory=$1
	shift
	sed -e "s/^\(${rule} =.*\)${directory}\(.*\)$/\1\2/" -i $@ \
	  || die "Could not strip director ${directory} from build."
}
src_prepare() {
	# Various glib marshaller churn could break build against a different
	# glib version, force regeneration
	rm -v gdk/gdkmarshalers.{c,h} gtk/gtkmarshal.{c,h} gtk/gtkmarshalers.{c,h} \
	  perf/marshalers.{c,h} gtk/gtkaliasdef.c gtk/gtkalias.h || die
	# Stop trying to build unmaintained docs, bug #349754, upstream bug #623150
	strip_builddir SUBDIRS tutorial docs/Makefile.{am,in}
	strip_builddir SUBDIRS faq docs/Makefile.{am,in}
	# -O3 and company cause random crashes in applications, bug #133469
	replace-flags -O3 -O2
	strip-flags
	# don't waste time building tests
	strip_builddir SRC_SUBDIRS tests Makefile.{am,in}
	strip_builddir SUBDIRS tests gdk/Makefile.{am,in} gtk/Makefile.{am,in}
	 if ! use examples; then
	  # don't waste time building demos
	  strip_builddir SRC_SUBDIRS demos Makefile.{am,in}
	fi
	 # Fix tests running when building out of sources, bug #510596, upstream bug #730319
	eapply "${FILESDIR}"/${PN}-2.24.24-out-of-source.patch
	 # Rely on split gtk-update-icon-cache package, bug #528810
	eapply "${FILESDIR}"/${PN}-2.24.31-update-icon-cache.patch
	 # Upstream gtk-2-24 branch up to 2018-09-08 state, bug #650536 safety
	eapply "${FILESDIR}"/patches-2.24
	 # Fix compilation with cups 2.x
	eapply "${FILESDIR}"/${PN}-2.0-cups2.patch
	 eautoreconf
	gnome3_src_prepare
}
src_configure() {
	ECONF_SOURCE=${S} \
	gnome3_src_configure \
	  --with-gdktarget=x11 \
	  --with-xinput \
	  $(use_enable cups cups auto) \
	  $(use_enable introspection) \
	  $(use_enable xinerama) \
	  --disable-papi \
	  --enable-man \
	  --with-xml-catalog="${EPREFIX}"/etc/xml/catalog \
	  CUPS_CONFIG="${EPREFIX}/usr/bin/${CHOST}-cups-config"
	# work-around gtk-doc out-of-source brokedness
	local d
	for d in gdk gtk libgail-util; do
	  ln -s "${S}"/docs/reference/${d}/html docs/reference/${d}/html || die
	done
}
src_install() {
	gnome3_src_install
	# see bug #133241
	# Also set more default variables in sync with gtk3 and other distributions
	echo 'gtk-fallback-icon-theme = "gnome"' > "${T}/gtkrc"
	echo 'gtk-theme-name = "Adwaita"' >> "${T}/gtkrc"
	echo 'gtk-icon-theme-name = "Adwaita"' >> "${T}/gtkrc"
	echo 'gtk-cursor-theme-name = "Adwaita"' >> "${T}/gtkrc"
	insinto /usr/share/gtk-2.0
	doins "${T}"/gtkrc
	einstalldocs
}
pkg_preinst() {
	gnome3_pkg_preinst
	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache"
	if [[ -e ${EROOT}${cache} ]]; then
	  cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
	  touch "${ED}"/${cache} || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
	gnome3_query_immodules_gtk2 \
	  || ewarn "Update immodules cache had some problems (for ${ABI}) (this may be transient)"
	GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	if [ -e "${EROOT%/}/etc/gtk-2.0/gtk.immodules" ]; then
	  elog "File /etc/gtk-2.0/gtk.immodules has been moved to \$CHOST"
	  elog "aware location. Removing deprecated file."
	  rm -f ${EROOT%/}/etc/gtk-2.0/gtk.immodules
	fi
	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gtk.immodules" ]; then
	  elog "File /etc/gtk-2.0/gtk.immodules has been moved to"
	  elog "${EROOT%/}/usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache"
	  elog "Removing deprecated file."
	  rm -f ${EROOT%/}${GTK2_CONFDIR}/gtk.immodules
	fi
	# pixbufs are now handled by x11-libs/gdk-pixbuf
	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders" ]; then
	  elog "File ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
	  elog "Removing deprecated file."
	  rm -f ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders
	fi
	# two checks needed since we dropped multilib conditional
	if [ -e "${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders" ]; then
	  elog "File ${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
	  elog "Removing deprecated file."
	  rm -f ${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders
	fi
	if [ -e "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]* ]; then
	  elog "You need to rebuild ebuilds that installed into" "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]*
	  elog "to do that you can use qfile from portage-utils:"
	  elog "emerge -va1 \$(qfile -qC ${EPREFIX}/usr/lib/gtk-2.0/2.[^1]*)"
	fi
}
pkg_postrm() {
	gnome3_pkg_postrm
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
	  rm -f "${EROOT}"usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache
	fi
}


# vim: filetype=ebuild
