#!/bin/bash

IMAGE_NAME="quay.io/team-helium/miner:gateway-latest"
CONTAINER_NAME="helium-miner"

CURRENT_IMAGE_ID=$(docker images -q $IMAGE_NAME)

docker pull $IMAGE_NAME

LATEST_IMAGE_ID=$(docker images -q $IMAGE_NAME)

if [ -f /etc/bobcat-version ]; then
    BOBCAT_VERSION=$(cat /etc/bobcat-version)

    case "$BOBCAT_VERSION" in
        280)
            I2C_NUM=1
            ;;
        285)
            I2C_NUM=2
            ;;
        29*)
            I2C_NUM=5
            ;;
        *)
            echo "Unknown version: $BOBCAT_VERSION. Exiting."
            exit 1
            ;;
    esac
else
    echo "/etc/bobcat-version not found. Exiting."
    exit 1
fi

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$CURRENT_IMAGE_ID" != "$LATEST_IMAGE_ID" ]; then
            echo "Updating Miner to Latest Version..."
            
            docker stop $CONTAINER_NAME
            docker rm $CONTAINER_NAME
            
            docker run -d --privileged \
                --name $CONTAINER_NAME \
                -e GW_KEYPAIR="ecc://i2c-$I2C_NUM:96?slot=0" \
                -e GW_ONBOARDING="ecc://i2c-$I2C_NUM:96?slot=15" \
                -e RUST_BACKTRACE=1 \
                -e GW_LISTEN=0.0.0.0:1680 \
                --network host \
                --restart unless-stopped \
                --device "/dev/i2c-$I2C_NUM:/dev/i2c-$I2C_NUM:rwm" \
                $IMAGE_NAME \
                helium_gateway server

            echo "Helium Miner has been updated and is now running."
        else
            echo "Miner is running and up to date."
        fi
    else
        echo "Container exists but is not running. Starting the container..."
        
        docker start $CONTAINER_NAME
    fi
else
    echo "Container does not exist. Starting a new instance..."
    
    docker run -d --privileged \
        --name $CONTAINER_NAME \
        -e GW_KEYPAIR="ecc://i2c-$I2C_NUM:96?slot=0" \
        -e GW_ONBOARDING="ecc://i2c-$I2C_NUM:96?slot=15" \
        -e RUST_BACKTRACE=1 \
        -e GW_LISTEN=0.0.0.0:1680 \
        --network host \
        --restart unless-stopped \
        --device "/dev/i2c-$I2C_NUM:/dev/i2c-$I2C_NUM:rwm" \
        $IMAGE_NAME \
        helium_gateway server

    echo "Helium Miner is now running."
fi

