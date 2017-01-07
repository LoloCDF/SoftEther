#!/bin/bash

############################################################
# Archivo: configurar-dhcp-en-interfaz.sh                  #
# Autor: Manuel Aragón Añino                               #
# Fecha: 05/01/2017                                        #
#                                                          #
# Descripción: este script configurará el SoftEther        #
# VPN client para conectarse a SoftEther VPN Server /      #
# VPN Bridge.                                              #
#                                                          #
# Uso: . configurar-dhcp-en-interfaz.sh INTERFAZ           #
############################################################


IF=$1

if [ -z $IF ]; then
    IF=eth1
fi

echo "DEVICE=$IF
BOOTPROTO=dhcp
ONBOOT=yes" > /etc/sysconfig/network-scripts/ifcfg-$IF

echo "DHCP configurado en la interfaz $IF."
