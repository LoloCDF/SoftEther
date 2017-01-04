#!/bin/bash

############################################################
# File: L2TP_v3-over-IPsec_EtherIP_-server.sh              #
# Author: Manuel Aragón Añino                              #
# Date: 26/12/2016                                         #
#                                                          #
# Description: this shell script will enable L2TPv2 over   #
# IPsec protocol on the choosen server.                    #
#                                                          #
# Usage: . L2TP_v3-over-IPsec_EtherIP_-server.sh SERVER_IP #
############################################################

SERVER=$1
VHUB=$2

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

vpncmd $SERVER:5555 /SERVER /CMD IPsecEnable /L2TP:no /L2TPRAW:no /ETHERIP:yes /PSK:abcd /DEFAULTHUB:$VHUB &> /dev/null

echo "L2TPv3 over IPsec (EtherIP) enabled on $SERVER server with $VHUB default virtual hub."
