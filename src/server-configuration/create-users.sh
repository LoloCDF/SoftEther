#!/bin/bash

############################################################
# File: create-users.sh                                    #
# Author: Manuel Aragón Añino                              #
# Date: 19/12/2016                                         #
#                                                          #
# Description: this shell script will create a virtual hub #
# and ten users in it.                                     #
#                                                          #
# Usage: . create-users.sh SERVER_IP VHOST_NAME            #
############################################################

SERVER=$1
VHUB=$2

NUSERS=10

if [ -z $SERVER ]; then 
    SERVER=127.0.0.1
fi

if [ -z $VHUB ]; then
    VHUB=DEFAULT
fi

i=0

echo "Creating group and users on $SERVER server and $VHUB virtual hub..."

# First, we have to create the default group
vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD GroupCreate default /REALNAME:default /NOTE:default &> /dev/null

i=0
# Now, we start creating the users
while [ $i -lt $NUSERS ]; do
    vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD UserCreate user$i /GROUP:default /REALNAME:user$i /NOTE:user$i &> /dev/null
    
    # We set the user's password as the username
    vpncmd $SERVER:5555 /SERVER /HUB:$VHUB /CMD UserPasswordSet user$i /PASSWORD:user$i &> /dev/null
    echo "'user$i' created."
    i=$((i+1))
done

echo "Done."
