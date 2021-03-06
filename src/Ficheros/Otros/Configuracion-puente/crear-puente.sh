#!/bin/bash

############################################################
# Archivo: crear-puente.sh                                 #
# Autor: Manuel Aragón Añinov                              #
# Fecha: 05/01/2017                                        #
#                                                          #
# Descripción: este script configurará SoftEther           #
# VPN client para conectarse a SoftEther VPN Server /      #
# VPN Bridge.                                              #
#                                                          #
# Uso: . crear-puente.sh SERVER_IP PUERTO    #
#        INTERFAZ                                          #
############################################################


SERVER=$1
PORT=$2
DEVICE=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $PORT ]; then
    PORT=5555
fi

if [ -z $DEVICE ]; then
    DEVICE=eth1
fi

# Hay que poner la interfaz en modo promiscuo
ifconfig $DEVICE promisc

# Hacemos el puente
vpncmd $SERVER:$PORT /SERVER /CMD:BridgeCreate BRIDGE /DEVICE:$DEVICE &> /dev/null
