#!/bin/bash

############################################################
# File: install-bridge.sh                                  #
# Author: Manuel Aragón Añino                              #
# Date: 04/01/2017                                         #
#                                                          #
# Description: installation script for SoftEther VPN       #
# Bridge.                                                  #
#                                                          #
# Usage: . install-bridge.sh                               #
############################################################

# Control variables
INSTALLED=FALSE
ROOT=FALSE

# We get the current user
user=$(whoami)

# We have to check if we are root
if [ "$user" != "root" ]; then
	echo "In order to install correctly, you need to install as root user."
else
	ROOT=TRUE
fi

# We have to check if the server is already installed
ls /usr/local/vpnbridge &> /dev/null

if [ $? -eq 0 ]; then
	echo "Bridge already installed."
	INSTALLED=TRUE
fi

if [ $INSTALLED = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Decompressing SoftEther Bridge..."
	tar xzvf softether-vpnbridge-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Installing..."
	cd vpnbridge
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnbridge /usr/local/
	
	# We change the actual PATH variable value
	echo $PATH > /usr/local/vpnbridge/PATH.bck
	export PATH="$PATH:/usr/local/vpnbridge/"
	# We have to change the default PATH value
	ls /usr/local/vpnclient &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Client found."
		echo "s" | cp -f ./files/path-bridge-client.bck ~/.bash_profile &> /dev/null
	else
		echo "Client not found."
		echo "s" | cp -f ./files/path-bridge.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Bridge installed in /usr/local/, you can check it running 'vpncmd' command."	
	cp -f ./files/vpnbridge /etc/init.d
	chmod 755 /etc/init.d/vpnbridge
	/sbin/chkconfig --add vpnbridge
	
	cp -f ./files/vpn_bridge.config /usr/local/vpnbridge

	service vpnbridge start &> /dev/null
	
	echo "Service already running."
fi
