#!/bin/bash

############################################################
# Archivo: activar-dhcp.sh                                 #
# Autor: Manuel Aragón Añino                               #
# Fecha: 26/12/2016                                        #
#                                                          #
# Descripción: este script activa el DHCP pero no lo       #
# configura                                                #
#                                                          #
# Uso: . activar-dhcp.sh SERVER_IP VHUB_NAME               #
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
echo "Virtual DHCP server activado en  $SERVER server / $VHUB virtual hub."
