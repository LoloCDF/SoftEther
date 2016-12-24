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
	tar xzvf softether-vpnserver-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Installing..."
	cd vpnserver
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnserver /usr/local/
	
	# We change the actual PATH variable value
	echo $PATH > /usr/local/vpnserver/PATH.bck
	export PATH="$PATH:/usr/local/vpnserver/"
	# We have to change the default PATH value
	ls /usr/local/vpnclient &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Client found."
		echo "s" | cp -f ./files/path-server-client.bck ~/.bash_profile &> /dev/null
	else
		echo "Client not found."
		echo "s" | cp -f ./files/path-server.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Server installed in /usr/local/, you can check it running 'vpncmd' command."	
	cp -f ./files/vpnserver /etc/init.d
	chmod 755 /etc/init.d/vpnserver
	/sbin/chkconfig --add vpnserver
	service vpnserver start &> /dev/null
	service vpnserver stop &> /dev/null
	echo "You can now start the service."
fi
