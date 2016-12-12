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

# We have to check if the server is already installed
ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	echo "Server already installed."
	INSTALLED=TRUE
fi

if [ $INSTALLED = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Decompressing SoftEther Server..."
	tar xzvf softether-vpnserver-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz
	echo "Installing..."
	cd vpnserver
	make
	cd ../
	mv vpnserver /usr/local/
	
	# We change the actual PATH variable value
	echo $PATH > /usr/local/vpnserver/PATH.bck
	export PATH="$PATH:/usr/local/vpnserver/"
	
	# We have to change the default PATH value
	ls /usr/local/vpnclient > /dev/null
	if [ $? -eq 0 ]; then
		cp -f ./files/path-server-client.bck ~/.bash_profile
	else
		cp -f ./files/path-server.bck ~/.bash_profile
	fi

	echo "SoftEther Server installed in /usr/local/, you can check it running 'vpncmd' command."	
	echo "Setting up the first configuration..."
	cp -f ./files/vpnserver /etc/init.d
	chmod 755 /etc/init.d/vpnserver
	/sbin/chkconfig --add vpnserver
	service vpnserver start
	service vpnserver stop
	echo "You can now start the service."
	ls /usr/local/vpnserver/vpn_server.config &> /dev/null
	
	while [ $? -ne 0 ]; do
		ls /usr/local/vpnserver/vpn_server.config &> /dev/null
	done
	cp /usr/local/vpnserver/vpn_server.config /usr/local/vpnserver/vpn_server.config.bck &> /dev/null
fi
