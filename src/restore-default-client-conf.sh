#!/bin/bash
HOST=$1

if [ -z "$HOST" ]; then
	HOST="localhost"
fi

# We have to check if the configuration backup exists
ls /usr/local/vpnclient/vpn_client.config.bck &> /dev/null

if [ $? -eq 0 ]; then
	echo "Restoring default configuration..."
	rm -f /usr/local/vpnclient/vpn_client.config
	cp /usr/local/vpnclient/vpn_client.config.bck /usr/local/vpnclient/vpn_client.config		
	echo "Done. Restarting service in order to load the new configuration..."
	service vpnclient restart
	
	echo "Removing VPN interfaces..."
	INTERFACES=`vpncmd "$HOST" /CLIENT /CMD NicList | grep "Virtual Network Adapter Name|" | cut -d "|" -f 2`

	printf '%s\n' "$INTERFACES" | while IFS= read -r line; do
   		vpncmd "$HOST" /CLIENT /CMD NicDelete "$line" &> /dev/null
	done
	
	echo "Done."
else
	echo "vpn_client.config.bck not found."
fi
