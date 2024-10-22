#!/bin/bash

BOBCAT_VERSION=$(cat /etc/bobcat-version)

if [[ $BOBCAT_VERSION == 29* || $BOBCAT_VERSION == 285 ]]; then
    RUNNING=$(sudo docker inspect --format "{{.State.Running}}" pktfwd)

    if [ "$RUNNING" == "true" ]; then
        echo "1" > /var/dashboard/statuses/packet-forwarder
    else
        echo "0" > /var/dashboard/statuses/packet-forwarder
    fi

elif [[ $BOBCAT_VERSION == 280 ]]; then
    sudo pgrep lora_pkt_+ > /var/dashboard/statuses/packet-forwarder
fi
