#!/bin/bash

############################################################
# Archivo: desinstalar-server.sh                           #
# Autor: Manuel Aragón Añino                               #
# Fecha: 11/12/2016                                        #
#                                                          #
# Descripción: script de desinstalaciób oara SoftEther VPN #
# Server.                                                  #
#                                                          #
# Uso: . desinstalar-server.sh                             #
############################################################

# Comprobamos que seamos root
ROOT=FALSE
USUARIO=$(whoami)

if [ "$USUARIO" != "root" ]; then
	echo "Para poder desinstalar, necesitas ser root."
else
	ROOT=TRUE
fi

# Comprobamos si el servidor está instalado
INSTALADO=FALSE

ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	INSTALADO=TRUE
else
	echo "SoftEther VPN Server no está instalado."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALADO = "TRUE" ]; then	
	service vpnserver stop &> /dev/null
	
	# Restauramos el valor de la variable PATH
	PATHBCK=$(cat /usr/local/vpnserver/PATH.bck)
	export PATH="$PATHBCK"

	# Restauramos el valor por defecto de la variable PATH
	rm -f ~/.bash_profile
	cp ../Otros/Ficheros/path.bck ~/.bash_profile
	rm -rf /usr/local/vpnserver /etc/init.d/vpnserver
	echo "SoftEther VPN Server se ha desinstalado correctamente."
fi
