#!/bin/bash

############################################################
# File: first-setting-server.sh                            #
# Author: Manuel Aragón Añino                              #
# Date: 02/01/2017                                         #
#                                                          #
# Description: this script wil start and                   #
# configure the server and it features for the first       #
# laboratory setting.                                      #
#                                                          #
# Usage: . first-setting-server.sh                         #
############################################################

echo "Configuring the SoftEther VPN Server for the first laboratory setting..."

. ./server-configuration/create-users.sh
. ./server-configuration/enable-dhcp.sh 

# We have to set up the virtual DHCP server configuration
vpncmd 127.0.0.1:5555 /SERVER /HUB:DEFAULT /CMD:DhcpSet /START:10.0.0.2 /END:10.0.0.254 /MASK:255.255.255.0 /EXPIRE:7200 /GW:none /DNS:none /DNS2:none /DOMAIN:none /LOG:yes &> /dev/null

echo "The server is ready to accept client requests."
