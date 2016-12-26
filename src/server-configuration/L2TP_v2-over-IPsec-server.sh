#!/bin/bash

SERVER=$1

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER /SERVER /CMD IPsecEnable /L2TP:yes /L2TPRAW:no /ETHERIP:no /PSK:abcd /DEFAULTHUB:DEFAULT &> /dev/null

echo "L2TPv2 over IPsec enabled."
