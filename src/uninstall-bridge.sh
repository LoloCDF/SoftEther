#!/bin/bash

############################################################
# File: uninstall-bridge.sh                                #
# Author: Manuel Aragón Añino                              #
# Date: 04/01/2017                                         #
#                                                          #
# Description: uninstallation script for SoftEther VPN     #
# Bridge.                                                  #
#                                                          #
# Usage: . uninstall-bridge.sh                             #
############################################################

# We have to check if you are running as root user
ROOT=FALSE
user=$(whoami)

if [ "$user" != "root" ]; then
	echo "In order to uninstall correctly, you need to run this script as root user."
else
	ROOT=TRUE
fi

# We have to check if the server is installed
INSTALLED=FALSE

ls /usr/local/vpnbridge &> /dev/null

if [ $? -eq 0 ]; then
	INSTALLED=TRUE
else
	echo "SoftEther VPN Bridge is not installed."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALLED = "TRUE" ]; then	
	service vpnbridge stop &> /dev/null
	
	# We have to restore PATH variable
	PATHBCK=$(cat /usr/local/vpnbridge/PATH.bck)
	export PATH="$PATHBCK"

	# We have to restore default PATH variable
	rm -f ~/.bash_profile
	cp ./files/path.bck ~/.bash_profile
	rm -rf /usr/local/vpnbridge /etc/init.d/vpnbridge
	echo "SoftEther VPN Bridge has been uninstalled correctly."
fi
