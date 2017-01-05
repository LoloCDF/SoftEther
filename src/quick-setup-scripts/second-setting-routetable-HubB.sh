#!/bin/bash

IF=$1

if [ -z $IF ]; then
    IF=vpn_vpn0
fi

ip route add 10.0.0.0/24 via 20.0.0.1 dev $IF

echo "Added a route in order to reach 10.0.0.0 network."
