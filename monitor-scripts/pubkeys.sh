#!/bin/bash

ecc_addr=$(i2cdetect -y 5 | grep 60 | awk '{ print $2 }')
sleep 1

pubkey=$(cat /var/dashboard/statuses/pubkey)
[ "$pubkey" != "" ] && exit

data=$(sudo docker logs helium-miner | grep 'INFO run: gateway_rs::server' | tail -n 1)

if [[ $data =~ key=([^ ]+) ]]; then
  match="${BASH_REMATCH[1]}"
fi

echo "${match//-/ }" > /var/dashboard/statuses/animal_name

echo $match > /var/dashboard/statuses/pubkey
