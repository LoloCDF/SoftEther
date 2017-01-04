#!/bin/bash

############################################################
# File: reinstall-client.sh                                #
# Author: Manuel Aragón Añino                              #
# Date: 11/12/2016                                         #
#                                                          #
# Description: reinstallation script for SoftEther VPN     #
# Client.                                                  #
#                                                          #
# Usage: . reinstall-client.sh                             #
############################################################

ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	echo "Reinstalling SoftEther VPN client..."
	. uninstall-client.sh &> /dev/null
	. install-client.sh &> /dev/null
else
	echo "SoftEther VPN client not installed."
fi
