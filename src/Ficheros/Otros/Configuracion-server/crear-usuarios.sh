#!/bin/bash

############################################################
# Archivo: crear-usuarios.sh                               #
# Autor: Manuel Aragón Añino                               #
# Fecha: 19/12/2016                                        #
#                                                          #
# Descripción: este script creará un vhub y diez usuarios. #
#                                                          #
# Uso: . crear-usuarios.sh SERVER_IP VHUB                  #
############################################################

SERVER=$1
VHUB=$2

NUSERS=10

if [ -z $SERVER ]; then 
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

i=0

echo "Creando grupo y usuarios $SERVER server y $VHUB virtual hub..."

vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD GroupCreate default /REALNAME:default /NOTE:default &> /dev/null

i=0

while [ $i -lt $NUSERS ]; do
    vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD UserCreate user$i /GROUP:default /REALNAME:user$i /NOTE:user$i &> /dev/null
    
    vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD UserPasswordSet user$i /PASSWORD:user$i &> /dev/null
    echo "'user$i' creado."
    i=$((i+1))
done

echo "Hecho."
