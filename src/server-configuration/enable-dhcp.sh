SERVER=$1

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD NatEnable &> /dev/null
vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD DhcpEnable &> /dev/null
vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD SecureNatEnable &> /dev/null
echo "Virtual DHCP server enabled."
