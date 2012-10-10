#!/bin/sh

echo "#====================================="
echo "# Setting up GNOME desktop background "
echo "#-------------------------------------"

wallpaper="/usr/share/wallpapers/studio_wallpaper.jpg"

if [ ! -f $wallpaper ]; then
	echo "WARNING: $wallpaper not found"
	exit 0
fi

# works: sled 10
if [ -d "/etc/opt/gnome" ] && [ -d "/opt/gnome/" ]; then
	# sle10 has gconftool in /opt/gnome/bin, which is not in path
	/opt/gnome/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/opt/gnome/gconf/gconf.xml.defaults --type string -s /desktop/gnome/background/picture_filename $wallpaper
	/opt/gnome/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/opt/gnome/gconf/gconf.xml.defaults --type string -s /apps/gnome-session/options/splash_image $wallpaper
fi

# works: 11.4
if [ -d "/etc/gconf" ] && [ -d "/etc/gdm" ]; then
	gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.vendor --type string -s /desktop/gnome/background/picture_filename $wallpaper
	gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.vendor --type string -s /apps/gnome-session/options/splash_image $wallpaper
fi
