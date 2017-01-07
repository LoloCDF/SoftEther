#!/bin/bash

############################################################
# Archivo: desinstalar-puente.sh                           #
# Autor: Manuel Aragón Añino                               #
# Fecha: 04/01/2017                                        #
#                                                          #
# Descripción: script de desinstalación de SoftEther VPN   #
# Bridge.                                                  #
#                                                          #
# Uso: . desinstalar-puente.sh                             #
############################################################

# Comprobamos que somos root
ROOT=FALSE
USUARIO=$(whoami)

if [ "$USUARIO" != "root" ]; then
	echo "Para poder desinstalar, necesitas ser root."
else
	ROOT=TRUE
fi

# Comprobamos si el puente está ya instalado
INSTALADO=FALSE

ls /usr/local/vpnbridge &> /dev/null

if [ $? -eq 0 ]; then
	INSTALADO=TRUE
else
	echo "SoftEther VPN Bridge no está instalado."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALADO = "TRUE" ]; then	
	service vpnbridge stop &> /dev/null
	
	# Restauramos el valor de la variable PATH
	PATHBCK=$(cat /usr/local/vpnbridge/PATH.bck)
	export PATH="$PATHBCK"

	# Restauramos el valor por defecto de la variable PATH
	rm -f ~/.bash_profile
	cp ../Otros/Ficheros/path.bck ~/.bash_profile
	rm -rf /usr/local/vpnbridge /etc/init.d/vpnbridge
	echo "SoftEther VPN Bridge se ha desinstalado correctamente."
fi
