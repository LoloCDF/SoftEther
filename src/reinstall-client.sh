#!/bin/bash

ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	echo "Reinstalling SoftEther VPN client..."
	. uninstall-client.sh &> /dev/null
	. install-client.sh &> /dev/null
else
	echo "SoftEther VPN client not installed."
fi
