#!/bin/bash

SERVER=$1
NUSERS=10

if [ -z $SERVER ]; then 
    SERVER=127.0.0.1
fi

i=0

echo "Creating group and users on $SERVER server..."

# First, we have to create the default group
vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD GroupCreate default /REALNAME:default /NOTE:default &> /dev/null

i=0
# Now, we start creating the users
while [ $i -lt $NUSERS ]; do
    vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD UserCreate user$i /GROUP:default /REALNAME:user$i /NOTE:user$i &> /dev/null
    
    # We set the user's password as the username
    vpncmd $SERVER /SERVER /HUB:DEFAULT /CMD UserPasswordSet user$i /PASSWORD:user$i &> /dev/null
    echo "'user$i' created."
    i=$((i+1))
done

echo "Done."
