# We have to check if you are running as root user
ROOT=FALSE
user=$(whoami)

if [ "$user" != "root" ]; then
	echo "In order to uninstall correctly, you need to run this script as root user."
else
	ROOT=TRUE
fi

# We have to check sever is installed
INSTALLED=FALSE

ls /usr/local/vpnserver &> /dev/null

if [ $? -eq 0 ]; then
	INSTALLED=TRUE
else
	echo "SoftEther VPN Server is not installed."
fi

if [ $ROOT = "TRUE" ] && [ $INSTALLED = "TRUE" ]; then	
	PATHBCK=$(cat /usr/local/vpnserver/PATH.bck)
	export PATH="$PATHBCK"
	rm -rf /usr/local/vpnserver /etc/init.d/vpnserver
	echo "SoftEther VPN Server has been uninstalled correctly."
fi
