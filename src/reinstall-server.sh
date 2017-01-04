#!/bin/bash

############################################################
# File: reinstall-server.sh                                #
# Author: Manuel Aragón Añino                              #
# Date: 11/12/2016                                         #
#                                                          #
# Description: reinstallation script for SoftEther VPN     #
# Server.                                                  #
#                                                          #
# Usage: . reinstall-server.sh                             #
############################################################

ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	echo "Reinstalling VPN Server..."
	. uninstall-server.sh &> /dev/null
	. install-server.sh &> /dev/null

else
	echo "SoftEther VPN Server not installed."
fi
