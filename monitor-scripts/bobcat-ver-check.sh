#!/bin/bash

if test -d /opt/miner_data; then
  echo -n "X1" > /var/dashboard/statuses/bobcat_ver
fi

if test -d /opt/bobcat/miner_data; then
  echo -n "X2" > /var/dashboard/statuses/bobcat_ver
fi
