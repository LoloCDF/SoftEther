#!/bin/bash

############################################################
# File: first-setting-client.sh                            #
# Author: Manuel Aragón Añino                              #
# Date: 02/01/2017                                         #
#                                                          #
# Description: this script will start and                  #
# configure the client and it features for the first       #
# laboratory setting.                                      #
#                                                          #
# Usage: . first-setting-client.sh SERVER_IP USERNAME      #
############################################################

SERVER=$1
USER=$2
VHUB=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

if [ -z $USER ]; then
    USER=user0
fi

echo "Configuring SoftEther VPN Client..."

./client-configuration/ethernet-over-ssl-client.sh $SERVER $USER $VHUB

echo "Getting IP address on the virtual interface..."
ifdown vpn_vpn0 &> /dev/null
ifup vpn_vpn0 &> /dev/null

echo "Client configured."
