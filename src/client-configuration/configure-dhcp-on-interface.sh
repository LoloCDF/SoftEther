#!/bin/bash

IF=$1

if [ -z $IF ]; then
    IF=eth1
fi

echo "DEVICE=$IF
BOOTPROTO=dhcp
ONBOOT=yes" > /etc/sysconfig/network-scripts/ifcfg-$IF

echo "DHCP configured on $IF interface."
