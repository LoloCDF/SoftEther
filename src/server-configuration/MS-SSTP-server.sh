#!/bin/bash

############################################################
# File: MS-SSTP-server.sh                                  #
# Author: Manuel Aragón Añino                              #
# Date: 26/12/2016                                         #
#                                                          #
# Description: this shell script will enable MS-SSTP       #
# protocol on the choosen server.                          #
#                                                          #
# Usage: . MS-SSTP-server.sh SERVER_IP                     #
############################################################

SERVER=$1

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER:5555 /SERVER /CMD SstpEnable yes &> /dev/null

echo "MS-SSTP enabled ON $SERVER server."
