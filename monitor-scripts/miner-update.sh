#!/bin/bash

# Define the image name and container name
IMAGE_NAME="quay.io/team-helium/miner:gateway-latest"
CONTAINER_NAME="helium-miner"

# Get the current image ID
CURRENT_IMAGE_ID=$(docker images -q $IMAGE_NAME)

# Pull the latest version of the image
docker pull $IMAGE_NAME

# Get the latest image ID from the local Docker images
LATEST_IMAGE_ID=$(docker images -q $IMAGE_NAME)

if [ "$CURRENT_IMAGE_ID" == "$LATEST_IMAGE_ID" ]; then
    echo "Miner Up to Date"
else
    echo "Updating Miner to Latest Version..."
    
    # Stop and remove the existing container only if the update is needed
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME

    # Spin up a new instance of the miner
    docker run -d --privileged \
        --name $CONTAINER_NAME \
        -e GW_KEYPAIR=ecc://i2c-5:96?slot=0 \
        -e GW_ONBOARDING=ecc://i2c-5:96?slot=15 \
        -e RUST_BACKTRACE=1 \
        -e GW_LISTEN=0.0.0.0:1680 \
        --network host \
        --restart unless-stopped \
        --device /dev/i2c-5:/dev/i2c-5:rwm \
        $IMAGE_NAME \
        helium_gateway server

    # Check if the container is running
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Helium Miner is now running."
    else
        echo "Failed to start Helium Miner."
    fi
fi