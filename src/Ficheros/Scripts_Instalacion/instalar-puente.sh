#!/bin/bash

############################################################
# Archivo: instalar-puente.sh                              #
# Autor: Manuel Aragón Añino                               #
# Fecha: 04/01/2017                                        #
#                                                          #
# Descripción: script de instalación de SoftEther VPN      #
# Bridge.                                                  #
#                                                          #
# Uso: . instalar-puente.sh                                #
############################################################


INSTALADO=FALSE
ROOT=FALSE

# Obtenemos el usuario acutal
USUARIO=$(whoami)

# Tenemos que comprobar si somos root
if [ "$USUARIO" != "root" ]; then
	echo "Necesitas ser root para poder instalar el puente."
else
	ROOT=TRUE
fi

# Comprobamos si ya está instalado el puente
ls /usr/local/vpnbridge &> /dev/null

if [ $? -eq 0 ]; then
	echo "El puente ya está instalado."
	INSTALADO=TRUE
fi

if [ $INSTALADO = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Descomprimiendo SoftEther Bridge..."
	tar xzvf softether-vpnbridge-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Instalando..."
	cd vpnbridge
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnbridge /usr/local/
	
	# Cambiamos el valor de la variable PATH
	echo $PATH > /usr/local/vpnbridge/PATH.bck
	export PATH="$PATH:/usr/local/vpnbridge/"

	# Cambiamos el valor por defecto de la variable PATH
	ls /usr/local/vpnclient &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Se ha encontrado un cliente."
		echo "s" | cp -f ../Otros/Ficheros/path-bridge-client.bck ~/.bash_profile &> /dev/null
	else
		echo "No se ha encontrado el cliente."
		echo "s" | cp -f ../Otros/Ficheros/path-bridge.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Bridge instalado en /usr/local/, ahora dispones del comando vpncmd."	
	cp -f ../Otros/Ficheros/vpnbridge /etc/init.d
	chmod 755 /etc/init.d/vpnbridge
	/sbin/chkconfig --add vpnbridge
	
	cp -f ../Ficheros_Configuracion/vpn_bridge.config /usr/local/vpnbridge

	service vpnbridge start &> /dev/null
	
	echo "El servicio ya se ha puesto en marcha."
fi
