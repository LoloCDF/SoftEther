#!/bin/bash

SERVER=$1
PORT=$2
DEVICE=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $PORT ]; then
    PORT=5555
fi

if [ -z $DEVICE ]; then
    DEVICE=eth1
fi

# First, we have to set the interface to promisc mode
ifconfig $DEVICE promisc

# Now we have to bridge the interface
vpncmd $SERVER:$PORT /SERVER /CMD:BridgeCreate BRIDGE /DEVICE:$DEVICE
