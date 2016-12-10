user=$(whoami)

if [ "$user" != "root" ]; then
	echo "In order to uninstall correctly, you need to run this script as root user."
else
	PATHBCK=$(cat /usr/local/vpnserver/PATH.bck)
	export PATH="$PATHBCK"
	rm -rf /usr/local/vpnserver
	echo "SoftEther VPN Server has been uninstalled correctly."
fi
