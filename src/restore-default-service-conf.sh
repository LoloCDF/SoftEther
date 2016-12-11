# We have to check if the configuration backup exists
ls /usr/local/vpnserver/vpn_server.config.bck &> /dev/null

if [ $? -eq 0 ]; then
	echo "Restoring default configuration..."
	rm -f /usr/local/vpnserver/vpn_server.config
	cp /usr/local/vpnserver/vpn_server.config.bck /usr/local/vpnserver/vpn_server.config
	echo "Done. Restarting service in order to load the new configuration..."
	service vpnserver restart
fi
