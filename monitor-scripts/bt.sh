#!/bin/bash

bobcat_ver=$(cat /var/dashboard/statuses/bobcat_ver)
gateway_config_path="/opt/gateway_config"

data=$(sudo ${gateway_config_path}/bin/gateway_config advertise status)

echo $data > /var/dashboard/statuses/bt
