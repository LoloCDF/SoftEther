#!/bin/bash

SERVER=$1
PORT=$2
USER=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $PORT ]; then
    PORT=5555
fi

if [ -z $USER ]; then
    USER=user0
fi

vpncmd $SERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadeCreate default /SERVER:$SERVER:$PORT /HUB:DEFAULT /USERNAME:$USER
vpncmd $SERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadePasswordSet default /PASSWORD:$USER /TYPE:standard
vpncmd $SERVER:$PORT /SERVER /HUB:BRIDGE /CMD:CascadeOnline default

echo "Cascade connection is ready."
