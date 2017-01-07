#!/bin/bash

############################################################
# Archivo: configurar-puente.sh                            #
# Autor: Manuel Aragón Añino                               #
# Fecha: 05/01/2017                                        #
#                                                          #
# Descripción: este script configurará al puente VPN.      #
#                                                          #
# Uso: . configurar-puente.sh IP_PUENTE IP_SERVER USUARIO  #
# INTERFAZ VHUB                                            #
############################################################


BSERVER=$1
RSERVER=$2
USER=$3
DEVICE=$4
VHUB=$5

if [ -z $BSERVER ]; then
    BSERVER=127.0.0.1
fi

if [ -z $RSERVER ]; then
    RSERVER=127.0.0.1
fi

if [ -z $USER ]; then
    USER=user0
fi

if [ -z $DEVICE ]; then
    DEVICE=eth1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

# Establecemos la conexión en cascada con el servidor
. ../Configuracion-puente/cascade-connection.sh $BSERVER $RSERVER 5555 $USER $VHUB

# Ahora configuraremos el puente
. ../Configuracion-puente/crear-puente.sh $BSERVER 5555 $DEVICE

echo "El puente está configurado."
