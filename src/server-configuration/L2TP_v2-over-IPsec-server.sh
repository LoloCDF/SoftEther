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

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER:5555 /SERVER /CMD IPsecEnable /L2TP:yes /L2TPRAW:no /ETHERIP:no /PSK:abcd /DEFAULTHUB:DEFAULT &> /dev/null

echo "L2TPv2 over IPsec enabled on $SERVER server."
