# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1

DESCRIPTION="Compiler for Blueprint, a markup language for GTK user interfaces"
HOMEPAGE="https://gitlab.gnome.org/GNOME/blueprint-compiler"
SRC_URI="https://download.gnome.org/sources/blueprint-compiler/0.18/blueprint-compiler-0.18.0.tar.xz -> blueprint-compiler-0.18.0.tar.xz"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="*"
DOCS=(
	CONTRIBUTING.md
	MAINTENANCE.md
	NEWS.md
	README.md
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}
"
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	
"
src_configure() {
	local -a emesonargs=(
	  -Ddocs=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_fix_shebang "${ED}/usr/bin"
	python_optimize
}


# vim: filetype=ebuild
