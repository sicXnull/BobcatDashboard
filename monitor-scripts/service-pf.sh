#!/bin/bash

regionFile=$(head -n 1 /var/dashboard/region_config)

ln -sf /opt/packet_forwarder/configs/global_conf.json.sx1250."$regionFile" /opt/packet_forwarder/configs/global_conf.json

if [ "$(docker ps -aq -f name=pktfwd)" ]; then
    dockerRegion=$(docker inspect --format='{{ index .Config.Env }}' pktfwd | grep -oP 'REGION=\K\w+')

    if [ "$regionFile" != "$dockerRegion" ]; then
        echo "Region mismatch: Container region is $dockerRegion, config region is $regionFile."

        docker stop pktfwd
        docker rm pktfwd

        docker run -d --privileged \
            --name pktfwd \
            --network host \
            -v /opt/packet_forwarder/configs:/opt/packet_forwarder/configs \
            -v /opt/packet_forwarder/tools:/opt/packet_forwarder/tools \
            -e VENDOR=bobcat \
            -e REGION="$regionFile" \
            --restart=always \
            sicnull/pkt_fwd:latest

        echo "Container restarted with region $regionFile."
    else
        echo "Regions match. No action needed."
    fi
else
    echo "Container pktfwd does not exist. Starting a new container with region $regionFile."

    docker run -d --privileged \
        --name pktfwd \
        --network host \
        -v /opt/packet_forwarder/configs:/opt/packet_forwarder/configs \
        -v /opt/packet_forwarder/tools:/opt/packet_forwarder/tools \
        -e VENDOR=bobcat \
        -e REGION="$regionFile" \
        --restart=always \
        sicnull/pkt_fwd:latest

    echo "Container pktfwd started with region $regionFile."
fi
