#!/bin/bash

# Run docker inspect and capture the running status
RUNNING=$(sudo docker inspect --format "{{.State.Running}}" pktfwd)

# Check if the container is running and set the status accordingly
if [ "$RUNNING" == "true" ]; then
    echo "1" > /var/dashboard/statuses/packet-forwarder
else
    echo "0" > /var/dashboard/statuses/packet-forwarder
fi