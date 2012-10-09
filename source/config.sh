#!/bin/bash

#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$name]..."

#======================================
# SuSEconfig
#--------------------------------------
echo "** Running suseConfig..."
suseConfig

echo "** Running ldconfig..."
/sbin/ldconfig

sed --in-place -e 's/icewm/icewm-session/' /usr/bin/wmlist

#======================================
# Firewall Configuration
#--------------------------------------
echo '** Configuring firewall...'
chkconfig SuSEfirewall2_init on
chkconfig SuSEfirewall2_setup on

#======================================
# RPM GPG Keys Configuration
#--------------------------------------
echo '** Importing GPG Keys...'
rpm --import /studio/studio_rpm_key_0
rm /studio/studio_rpm_key_0
rpm --import /studio/studio_rpm_key_1
rm /studio/studio_rpm_key_1
rpm --import /studio/studio_rpm_key_2
rm /studio/studio_rpm_key_2
rpm --import /studio/studio_rpm_key_3
rm /studio/studio_rpm_key_3
rpm --import /studio/studio_rpm_key_4
rm /studio/studio_rpm_key_4
rpm --import /studio/studio_rpm_key_5
rm /studio/studio_rpm_key_5

sed --in-place -e 's/# solver.onlyRequires.*/solver.onlyRequires = true/' /etc/zypp/zypp.conf

# Enable sshd
chkconfig sshd on

#======================================
# Setting up overlay files 
#--------------------------------------
echo '** Setting up overlay files...'
mkdir -p /
mv '/studio/overlay-tmp/files///Anansi Software Extra.rar' '//Anansi Software Extra.rar'
chown nobody:nobody '//Anansi Software Extra.rar'
chmod 644 '//Anansi Software Extra.rar'
mkdir -p /
mv /studio/overlay-tmp/files///WallPapers.rar //WallPapers.rar
chown nobody:nobody //WallPapers.rar
chmod 644 //WallPapers.rar
test -d /studio || mkdir /studio
cp /image/.profile /studio/profile
cp /image/config.xml /studio/config.xml
rm -rf /studio/overlay-tmp
true

sh /studio/configure_gdm_theme.sh



sh /studio/configure_gnome_background.sh

