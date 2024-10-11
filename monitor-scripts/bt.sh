#!/bin/bash

bobcat_ver=$(cat /var/dashboard/statuses/bobcat_ver)

if [[ "$bobcat_ver" = "X1" ]]; then
    gateway_config_path="/opt/gateway_config"
fi

if [[ "$bobcat_ver" = "X2" ]]; then
    gateway_config_path="/opt/bobcat/gateway_config"
fi

data=$(sudo ${gateway_config_path}/bin/gateway_config advertise status)

echo $data > /var/dashboard/statuses/bt
