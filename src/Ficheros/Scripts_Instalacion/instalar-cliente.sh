#!/bin/bash

############################################################
# Archivo: instalar-cliente.sh                             #
# Autor: Manuel Aragón Añino                               #
# Fecha: 11/12/2016                                        #
#                                                          #
# Descripción: script de instalación del cliente VPN.      #
#                                                          #
# Uso: . instalar-cliente.sh                               #
############################################################

# Variables de control
INSTALADO=FALSE
ROOT=FALSE

# Obtenemos el usuario actual
USUARIO=$(whoami)

# Comprobamos que seamos root
if [ "$USUARIO" != "root" ]; then
	echo "Para poder instalar el cliente, necesitas ser root."
else
	ROOT=TRUE
fi

# Comprobamos si el cliente ya está instalado
ls /usr/local/vpnclient &> /dev/null

if [ $? -eq 0 ]; then
	echo "El cliente ya está instalado."
	INSTALADO=TRUE
fi

if [ $INSTALADO = "FALSE" ] && [ $ROOT = "TRUE" ]; then	
	echo "Descomprimiendo SoftEther Client..."
	tar xzvf softether-vpnclient-v4.22-9634-beta-2016.11.27-linux-x64-64bit.tar.gz &> /dev/null
	echo "Instalando..."
	cd vpnclient
	make i_read_and_agree_the_license_agreement &> /dev/null
	cd ../
	mv vpnclient /usr/local/
	
	# Si el cliente ya está instalado, borramos vpncmd
	ls /usr/local/vpnserver &> /dev/null
	if [ $? -eq 0 ]; then
		rm -f /usr/local/vpnclient/vpncmd
	fi
	
	# Cambiamos el valor de la variable PATH	
	echo $PATH > /usr/local/vpnclient/PATH.bck
	export PATH="$PATH:/usr/local/vpnclient/"
	
	# Cambiamos el valor por defecto de la variable PATH
	ls /usr/local/vpnserver &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Se ha encontrado el servidor."
		echo "s" | cp -f ../Otros/Ficheros/path-server-client.bck ~/.bash_profile &> /dev/null
	else
		echo "No se ha encontrado el servidor."
		echo "s" | cp -f ../Otros/Ficheros/path-client.bck ~/.bash_profile &> /dev/null
	fi

	echo "SoftEther Client instalado en /usr/local/. Configurando el servicio..."
	cp -f ../Otros/Ficheros/vpnclient /etc/init.d/
	chmod 755 /etc/init.d/vpnclient
	/sbin/chkconfig --add vpnclient
	service vpnclient start &> /dev/null
	echo "Ya está el cliente instalado."       		
fi
