#!/bin/bash

output=$(docker exec helium-miner helium_gateway key info)

name=$(echo "$output" | jq -r '.name')
key=$(echo "$output" | jq -r '.key')

if [ -n "$name" ]; then
    echo "$name" > /var/dashboard/statuses/animal_name
fi

if [ -n "$key" ]; then
    echo "$key" > /var/dashboard/statuses/pubkey
fi
