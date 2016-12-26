#!/bin/bash

SERVER=$1

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER /SERVER /CMD IPsecEnable /L2TP:no /L2TPRAW:no /ETHERIP:yes /PSK:abcd /DEFAULTHUB:DEFAULT &> /dev/null

echo "L2TPv3 over IPsec (EtherIP) enabled."
