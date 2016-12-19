#!/bin/bash

SERVER=$1
NUSERS=10

if [ -z $SERVER ]; then 
	SERVER=127.0.0.1
fi

i=0

while [ $i -le $NUSERS ]; do
	vpncmd $SERVER /SERVER /CMD Hub DEFAULT 
	vpncmd $SERVER /SERVER /CMD UserCreate user$i /GROUP:user$i /REALNAME:user$i /NOTE:user$i
        vpncmd $SERVER /SERVER /CMD Hub DEFAULT 
	vpncmd $SERVER /SERVER /CMD UserPasswordSet user$i /PASSWORD:user$i
	i=i+1
done
  
