#!/bin/bash

############################################################
# Archivo: ethernet-sobre-ssl-cliente.sh                   #
# Autor: Manuel Aragón Añino                               #
# Fecha: 19/12/2016                                        #
#                                                          #
# Descripción: este script configurará  SoftEther          #
# VPN client para conectarse a SoftEther VPN Server /      #
# VPN Bridge.                                              #
#                                                          #
# Uso: . ethernet-sobre-ssl-cliente.sh SERVER_IP USERNAME  #
#        VHUB_NAME                                         #
############################################################

SERVER=$1
PORT=$2
USER=$3
VHUB=$4

if [ -z "$SERVER" ]; then
    SERVER=127.0.0.1
fi

if [ -z "$PORT" ]; then
    PORT=5555
fi

if [ -z "$USER" ]; then
    USER=user0
fi

if [ -z "$VHUB"  ]; then
    VHUB=DEFAULT
fi

echo "Crear el adaptador virtual 'vpn0'..."
vpncmd localhost /CLIENT /CMD NicCreate vpn0 &> /dev/null
echo "s" | cp -f ../Ficheros/ifcfg-vpn_vpn0 /etc/sysconfig/network-scripts/ &> /dev/null

echo "Creando la conexión 'default'..."
vpncmd localhost /CLIENT /CMD AccountCreate default /SERVER:$SERVER:$PORT /HUB:$VHUB /USERNAME:$USER /NICNAME:vpn0 &> /dev/null

echo "Configurando la contraseña..."
vpncmd localhost /CLIENT /CMD AccountPasswordSet default /PASSWORD:$USER /TYPE:standard &> /dev/null

echo "Intentando conectar..."
vpncmd localhost /CLIENT /CMD AccountDisconnect default &> /dev/null
vpncmd localhost /CLIENT /CMD AccountConnect default &> /dev/null

