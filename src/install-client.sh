#!/bin/bash

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
	tar xzvf softether-vpnclient-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz
	echo "Installing..."
	cd vpnclient
	make
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
		echo "s" | cp -f ./files/path-server-client.bck ~/.bash_profile
	else
		echo "s" | cp -f ./files/path-client.bck ~/.bash_profile
	fi

	echo "SoftEther Client installed in /usr/local/. Configuring service..."
	cp -f ./files/vpnclient /etc/init.d/
	chmod 755 /etc/init.d/vpnclient
	/sbin/chkconfig --add vpnclient
	service vpnclient start &> /dev/null
	service vpnclient stop &> /dev/null
	echo "You can now start the service."
	ls /usr/local/vpnclient/vpn_client.config &> /dev/null
	
	while [ $? -ne 0 ]; do
		ls /usr/local/vpnclient/vpn_client.config &> /dev/null
	done
	cp /usr/local/vpnclient/vpn_client.config /usr/local/vpnclient/vpn_client.config.bck		
fi
