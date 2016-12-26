#!/bin/bash

SERVER=$1
USER=$2

if [ -z "$SERVER" ] || [ -z "$USER" ]; then
	echo "Usage: . ethernet-over-ssl-client.sh VPNSERVER USERNAME"

else
	echo "$SERVER $USER"
	echo "Creating Virtual Adapter 'vpn0'..."
	vpncmd localhost /CLIENT /CMD NicCreate vpn0 &> /dev/null

	echo "Creating connection settings 'default'..."
	vpncmd localhost /CLIENT /CMD AccountCreate default /SERVER:$SERVER:5555 /HUB:DEFAULT /USERNAME:$USER /NICNAME:vpn0 &> /dev/null

	echo "Setting connection password \(username by default\)..."
	vpncmd localhost /CLIENT /CMD AccountPasswordSet default /PASSWORD:$USER /TYPE:standard &> /dev/null

	echo "Attempting to connect..."
	vpncmd localhost /CLIENT /CMD AccountDisconnect default &> /dev/null
	vpncmd localhost /CLIENT /CMD AccountConnect default &> /dev/null
fi
