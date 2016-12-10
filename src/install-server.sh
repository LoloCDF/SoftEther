#!/bin/bash

user=$(whoami)

if [ "$user" != "root" ]; then
	echo "In order to install correctly, you need to install as root user."
else
	echo "Decompressing SoftEther Server..."
	tar xzvf softether-vpnserver-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz
	echo "Installing..."
	cd vpnserver
	make
	cd ../
	mv vpnserver /usr/local/
	echo $PATH > /usr/local/vpnserver/PATH.bck
	export PATH="$PATH:/usr/local/vpnserver/"
	echo $PATH	
	echo "SoftEther Server installed in /usr/local/, you can check it running 'vpncmd' command."	
fi
