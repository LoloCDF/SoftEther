#!/bin/bash

############################################################
# File: ethernet-over-ssl-client.sh                        #
# Author: Manuel Aragón Añino                              #
# Date: 19/12/2016                                         #
#                                                          #
# Description: this script will configure the SoftEther    #
# VPN client for connecting to a SoftEther VPN Server /    #
# VPN Bridge.                                              #
#                                                          #
# Usage: . ethernet-over-ssl-client.sh SERVER_IP USERNAME  #
#        VHUB_NAME                                         #
############################################################

SERVER=$1
USER=$2
VHUB=$3

if [ -z "$SERVER" ]; then
    SERVER=127.0.0.1
fi

if [ -z "$USER" ]; then
    USER=user0
fi

if [ -z "$VHUB"  ]; then
    VHUB=DEFAULT
fi

echo "Creating Virtual Adapter 'vpn0'..."
vpncmd localhost /CLIENT /CMD NicCreate vpn0 &> /dev/null

echo "Creating connection settings 'default'..."
vpncmd localhost /CLIENT /CMD AccountCreate default /SERVER:$SERVER:5555 /HUB:$VHUB /USERNAME:$USER /NICNAME:vpn0 &> /dev/null

echo "Setting connection password (username by default)..."
vpncmd localhost /CLIENT /CMD AccountPasswordSet default /PASSWORD:$USER /TYPE:standard &> /dev/null

echo "Attempting to connect..."
vpncmd localhost /CLIENT /CMD AccountDisconnect default &> /dev/null
vpncmd localhost /CLIENT /CMD AccountConnect default &> /dev/null

