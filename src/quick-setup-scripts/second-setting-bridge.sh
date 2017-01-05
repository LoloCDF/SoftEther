#!/bin/bash

BSERVER=$1
RSERVER=$2
USER=$3
DEVICE=$4
VHUB=$5

if [ -z $BSERVER ]; then
    BSERVER=127.0.0.1
fi

if [ -z $RSERVER ]; then
    RSERVER=127.0.0.1
fi

if [ -z $USER ]; then
    USER=user0
fi

if [ -z $DEVICE ]; then
    DEVICE=eth1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

# Firstly, we are going to set up the cascade connection to the server
. bridge-configuration/cascade-connection.sh $BSERVER $RSERVER 5555 $USER $VHUB

# Now we have to configure the bridge between physical and virtual if
. bridge-configuration/create-bridge.sh $BSERVER 5555 $DEVICE

echo "The bridge is ready."
