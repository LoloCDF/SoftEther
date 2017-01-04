#!/bin/bash

############################################################
# File: L2TP_v2-over-IPsec-server.sh                       #
# Author: Manuel Aragón Añino                              #
# Date: 26/12/2016                                         #
#                                                          #
# Description: this shell script will enable L2TPv2 over   #
# IPsec protocol on the choosen server.                    #
#                                                          #
# Usage: . L2TP_v2-over-IPsec-server.sh SERVER_IP          #
############################################################

SERVER=$1
VHUB=$2

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

vpncmd $SERVER:5555 /SERVER /CMD IPsecEnable /L2TP:yes /L2TPRAW:no /ETHERIP:no /PSK:abcd /DEFAULTHUB:$VHUB &> /dev/null

echo "L2TPv2 over IPsec enabled on $SERVER server with $VHUB default virtual hub."
