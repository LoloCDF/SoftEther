#!/bin/bash

############################################################
# File: install-client.sh                                  #
# Author: Manuel Aragón Añino                              #
# Date: 11/12/2016                                         #
#                                                          #
# Description: installation script for SoftEther VPN       #
# Client.                                                  #
#                                                          #
# Usage: . install-client.sh                               #
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

# We have to check if the client is already installed
ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	echo "Client already installed."
	INSTALLED=TRUE
fi

if [ $INSTALLED = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Decompressing SoftEther Client..."
	tar xzvf softether-vpnclient-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Installing..."
	cd vpnclient
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnclient /usr/local/
	
	# If the VPN server is also installed, we have to remove the client's vpncmd
	ls /usr/local/vpnserver &> /dev/null
	if [ $? -eq 0 ]; then
		rm -f /usr/local/vpnclient/vpncmd
	fi
	
	# We change the actual PATH value	
	echo $PATH > /usr/local/vpnclient/PATH.bck
	export PATH="$PATH:/usr/local/vpnclient/"
	
	# We have to change the default PATH value
	ls /usr/local/vpnserver &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Server found."
		echo "s" | cp -f ./files/path-server-client.bck ~/.bash_profile &> /dev/null
	else
		echo "Server not found."
		echo "s" | cp -f ./files/path-client.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Client installed in /usr/local/. Configuring service..."
	cp -f ./files/vpnclient /etc/init.d/
	chmod 755 /etc/init.d/vpnclient
	/sbin/chkconfig --add vpnclient
	service vpnclient start &> /dev/null
	echo "Service already running."       		
fi
