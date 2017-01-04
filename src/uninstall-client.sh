#!/bin/bash

############################################################
# File: uninstall-client.sh                                #
# Author: Manuel Aragón Añino                              #
# Date: 11/12/2016                                         #
#                                                          #
# Description: uninstallation script for SoftEther VPN     #
# Client.                                                  #
#                                                          #
# Usage: . uninstall-client.sh                             #
############################################################

# We have to check if you are running as root user
ROOT=FALSE
user=$(whoami)

if [ "$user" != "root" ]; then
	echo "In order to uninstall correctly, you need to run this script as root user."
else
	ROOT=TRUE
fi

# We have to check if the client is installed
INSTALLED=FALSE

ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	INSTALLED=TRUE
else
	echo "SoftEther VPN Client is not installed."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALLED = "TRUE" ]; then		
	service vpnclient stop &> /dev/null
	
	# We have to restore PATH variable
	PATHBCK=$(cat /usr/local/vpnclient/PATH.bck)
	export PATH="$PATHBCK"
	
	# We have to restore default PATH variable
	rm -f ~/.bash_profile
	cp ./files/path.bck ~/.bash_profile
	rm -rf /usr/local/vpnclient /etc/init.d/vpnclient
	echo "SoftEther VPN Client has been uninstalled correctly."
fi
