#!/bin/bash

SERVER=$1

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

vpncmd $SERVER /SERVER /CMD SstpEnable yes &> /dev/null

echo "MS-SSTP enabled."
