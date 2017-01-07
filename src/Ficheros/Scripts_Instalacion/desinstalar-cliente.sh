#!/bin/bash

############################################################
# Archivo: desinstalar-cliente.sh                          #
# Autor: Manuel Aragón Añino                               #
# Fecha: 11/12/2016                                        #
#                                                          #
# Descripción: script de desinstalación de SoftEther VPN   #
# Client.                                                  #
#                                                          #
# Usage: . desinstalar-cliente.sh                          #
############################################################

# Comprobamos si somos root
ROOT=FALSE
USUARIO=$(whoami)

if [ "$USUARIO" != "root" ]; then
	echo "Para poder desinstalar, necesitas ser root."
else
	ROOT=TRUE
fi

# Comprobamos si el cliente está instalado
INSTALADO=FALSE

ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	INSTALADO=TRUE
else
	echo "SoftEther VPN Client no está instalado."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALADO = "TRUE" ]; then		
	service vpnclient stop &> /dev/null
	
	# Restauramos el valor de la variable PATH
	PATHBCK=$(cat /usr/local/vpnclient/PATH.bck)
	export PATH="$PATHBCK"
	
	# Restauramos el valor por defecto de la variable PATH
	rm -f ~/.bash_profile
	cp ../Otros/Ficheros/path.bck ~/.bash_profile
	rm -rf /usr/local/vpnclient /etc/init.d/vpnclient
	echo "SoftEther VPN Client se ha desinstalado correctamente."
fi
