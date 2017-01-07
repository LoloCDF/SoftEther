#!/bin/bash

############################################################
# Archivo: configurar-routetable-HubA.sh                   #
# Author: Manuel Aragón Añino                              #
# Fecha: 05/01/2017                                        #
#                                                          #
# Descripción: este script configurará la tabla de         # 
# enrutamiento de un equipo conectado al HubA.             #
#                                                          #
# Uso: . configurar-routetable-HubA.sh                     #
############################################################


IF=$1

if [ -z $IF ]; then
    IF=vpn_vpn0
fi

ip route add 20.0.0.0/24 via 10.0.0.1 dev $IF

echo "Añadida la ruta para alcanzar la red 20.0.0.0/24."
