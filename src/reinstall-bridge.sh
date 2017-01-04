#!/bin/bash

############################################################
# File: reinstall-bridge.sh                                #
# Author: Manuel Aragón Añino                              #
# Date: 04/01/2017                                         #
#                                                          #
# Description: reinstallation script for SoftEther VPN     #
# Bridge.                                                  #
#                                                          #
# Usage: . reinstall-bridge.sh                             #
############################################################

ls /usr/local/vpnbridge &> /dev/null

if [ $? -eq 0 ]; then
	echo "Reinstalling VPN Bridge..."
	. uninstall-bridge.sh &> /dev/null
	. install-bridge.sh &> /dev/null

else
	echo "SoftEther VPN Bridge not installed."
fi
