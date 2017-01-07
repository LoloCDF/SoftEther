#!/bin/bash

############################################################
# Archivo: configurar-cliente.sh                           #
# Autor: Manuel Aragón Añino                               #
# Fecha: 02/01/2017                                        #
# Descripción: este script configurará al cliente.         #
#                                                          #
# Uso: . configurar-cliente.sh SERVER_IP USERNAME VHUB     #
############################################################

SERVER=$1
USER=$2
VHUB=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $USER ]; then
    USER=user0
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

echo "Configurando SoftEther VPN Client..."

. ../Configuracion-cliente/ethernet-sobre-ssl-cliente.sh $SERVER 5555 $USER $VHUB

echo "Obteniendo dirección IP en la interfaz virtual..."
ifdown vpn_vpn0 &> /dev/null
ifup vpn_vpn0 &> /dev/null

echo "Cliente configurado."
