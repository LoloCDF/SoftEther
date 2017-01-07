#!/bin/bash

############################################################
# Archivo: configurar-server.sh                            #
# Autor: Manuel Aragón Añino                               #
# Fecha: 05/01/2017                                        #
#                                                          #
# Descripción: este script configurará el servidor.        #
#                                                          #
# Uso: . configurar-server.sh                              #
############################################################


# Creamos los dos VHubs, "HubA" & "HubB"
vpncmd 127.0.0.1:5555 /SERVER /CMD:HubCreate HubA /PASSWORD: &> /dev/null
vpncmd 127.0.0.1:5555 /SERVER /CMD:HubCreate HubB /PASSWORD: &> /dev/null

echo "Se han creado los hubs."

# Creamos los usuarios en cada hub
. ../Configuracion-server/crear-usuarios.sh 127.0.0.1 HubA
. ../Configuracion-server/crear-usuarios.sh 127.0.0.1 HubB

# Activamos DHCP
. ../Configuracion-server/activar-dhcp.sh 127.0.0.1 HubA
. ../Configuracion-server/activar-dhcp.sh 127.0.0.1 HubB

vpncmd 127.0.0.1:5555 /SERVER /HUB:HubA /CMD:DhcpSet /START:10.0.0.2 /END:10.0.0.254 /MASK:255.255.255.0 /EXPIRE:7200 /GW:none /DNS:none /DNS2:none /DOMAIN:none /LOG:yes &> /dev/null

vpncmd 127.0.0.1:5555 /SERVER /HUB:HubB /CMD:DhcpSet /START:20.0.0.2 /END:20.0.0.254 /MASK:255.255.255.0 /EXPIRE:7200 /GW:none /DNS:none /DNS2:none /DOMAIN:none /LOG:yes &> /dev/null

echo "DHCP activado y configurado para ambos hubs."

# Ahora vamos a activar el router
vpncmd 127.0.0.1:5555 /SERVER /CMD:RouterAdd default &> /dev/null
vpncmd 127.0.0.1:5555 /SERVER /CMD:RouterIfAdd default /HUB:HubA /IP:10.0.0.1/255.255.255.0 &> /dev/null
vpncmd 127.0.0.1:5555 /SERVER /CMD:RouterIfAdd default /HUB:HubB /IP:20.0.0.1/255.255.255.0 &> /dev/null
vpncmd 127.0.0.1:5555 /SERVER /CMD:RouterStart default &> /dev/null

echo "Se ha iniciado el router."
