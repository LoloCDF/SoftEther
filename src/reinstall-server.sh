#!/bin/bash

ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	echo "Reinstalling VPN Server..."
	. uninstall-server.sh &> /dev/null
	. install-server.sh &> /dev/null

else
	echo "SoftEther VPN Server not installed."
fi
