#!/bin/bash

############################################################
# Archivo: instalar-servidor.sh                            #
# Autor: Manuel Aragón Añino                               #
# Fecha: 11/12/2016                                        #
#                                                          #
# Descripción: script de instalación del servidor VPN.     #
#                                                          #
# Uso: . instalar-servidor.sh                              #
############################################################

INSTALADO=FALSE
ROOT=FALSE

# Vemos que usuario ha ejecutado
USUARIO=$(whoami)

# Y comprobamos que es root
if [ "$USUARIO" != "root" ]; then
	echo "Para poder instalar, necesitas privilegios de root."
else
	ROOT=TRUE
fi

# Comprobamos si el servidor está ya instalado
ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	echo "El servidor está ya instalado."
	INSTALADO=TRUE
fi

if [ $INSTALADO = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Descomprimiendo SoftEther Server..."
	tar xzvf softether-vpnserver-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Instalando..."
	cd vpnserver
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnserver /usr/local/
	
	# Cambiamos el valor de la variable PATH
	echo $PATH > /usr/local/vpnserver/PATH.bck
	export PATH="$PATH:/usr/local/vpnserver/"

	# Cambiamos el valor por defecto de la variable PATH
	ls /usr/local/vpnclient &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Se ha encontrado el cliente VPN instalado."
		echo "s" | cp -f ../Otros/Ficheros/path-server-client.bck ~/.bash_profile &> /dev/null
	else
		echo "No se ha encontrado ningún cliente."
		echo "s" | cp -f ../Otros/Ficheros/path-server.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Server instalado en /usr/local/, ya está disponible el comando vpncmd."	
	cp -f ../Otros/Ficheros/vpnserver /etc/init.d
	chmod 755 /etc/init.d/vpnserver
	/sbin/chkconfig --add vpnserver
	
	cp -f ../Ficheros_Configuracion/vpn_server.config /usr/local/vpnserver

	service vpnserver start &> /dev/null
	
	echo "Ya está iniciado el servicio."
fi
