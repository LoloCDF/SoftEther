#!/bin/bash

############################################################
# Archivo: cascade-connection.sh                           #
# Author: Manuel Aragón Añino                              #
# Date: 05/01/2017                                         #
#                                                          #
# Descripción: este script configurará el SoftEther        #
# VPN client para conectarse  a SoftEther VPN Server /     #
# VPN Bridge.                                              #
#                                                          #
# Uso: . cascade-connection.sh IP_PUENTE IP_SERVIDOR       #
#         PUERTO USUARIO VHUB                              #
############################################################


BSERVER=$1
RSERVER=$2
PORT=$3
USER=$4
VHUB=$5

if [ -z $BSERVER ]; then
    BSERVER=127.0.0.1
fi

if [ -z $RSERVER ]; then
    RSERVER=127.0.0.1
fi

if [ -z $PORT ]; then
    PORT=5555
fi

if [ -z $USER ]; then
    USER=user0
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

vpncmd $BSERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadeCreate default /SERVER:$RSERVER:$PORT /HUB:$VHUB /USERNAME:$USER &> /dev/null
vpncmd $BSERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadePasswordSet default /PASSWORD:$USER /TYPE:standard &> /dev/null
vpncmd $BSERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadeOnline default &> /dev/null

echo "Se ha establecido la conexión en cascada."
