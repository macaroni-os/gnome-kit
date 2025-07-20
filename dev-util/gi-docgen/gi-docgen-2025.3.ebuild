# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="A documentation generator for GObject-based libraries"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gi-docgen"
SRC_URI="https://files.pythonhosted.org/packages/55/e1/c32a1ee817fc7d11462b4ed8722b049c70dd61ce0b236f74e7cf4262412e/gi_docgen-2025.3.tar.gz -> gi_docgen-2025.3.tar.gz"

DEPEND=""
RDEPEND="
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/typogrify[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="|| ( Apache-2.0 GPL-3+ ) CC0-1.0 OFL-1.1 MIT GPL-3+ LGPL-2 MIT MPL-1.1 CC-By-SA-3"
KEYWORDS="*"
S="${WORKDIR}/gi_docgen-2025.3"