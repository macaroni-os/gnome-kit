# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Virtual for notification daemon dbus service"
SLOT="0"
KEYWORDS="*"
IUSE="gnome kde"
RDEPEND="gnome? ( || (
	    x11-misc/notification-daemon
	    gnome-base/gnome-shell
	  )
	)
	kde? ( kde-plasma/plasma-workspace )
	!gnome? ( !kde? ( || (
	      x11-misc/notification-daemon
	      xfce-extra/xfce4-notifyd
	      x11-wm/enlightenment[enlightenment_modules_notification]
	      x11-wm/enlightenment[e_modules_notification]
	      lxqt-base/lxqt-notificationd
	    )
	  )
	)
	
"

# vim: filetype=ebuild
