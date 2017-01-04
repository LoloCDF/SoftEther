#!/bin/bash

############################################################
# File: enable-dhcp.sh                                     #
# Author: Manuel Aragón Añino                              #
# Date: 26/12/2016                                         #
#                                                          #
# Description: this shell script will enable the dhcp      #
# feature on the choosen server and virtual hub. Keep in   #
# mind that it won't configure the dhcp server for you.    #
#                                                          #
# Usage: . enable-dhcp.sh SERVER_IP VHUB_NAME              #
############################################################

SERVER=$1
VHUB=$2

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD NatEnable &> /dev/null
vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD DhcpEnable &> /dev/null
vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD SecureNatEnable &> /dev/null
echo "Virtual DHCP server enabled on $SERVER server / $VHUB virtual hub."
