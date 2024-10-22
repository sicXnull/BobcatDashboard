#!/bin/bash

BOBCAT_VERSION=$(cat /etc/bobcat-version)

if [[ $BOBCAT_VERSION == 29* || $BOBCAT_VERSION == 285 ]]; then
    docker logs -f pktfwd 2>&1 | grep -E 'rxpk|txpk' --line-buffered | gawk '{ print strftime("%Y-%m-%d %H:%M:%S", systime(), 1), $0; system("") }'

elif [[ $BOBCAT_VERSION == 280 ]]; then
    ngrep -W byline port 1680 -d lo | grep -E 'rxpk|txpk' --line-buffered | gawk '{ print strftime("%Y-%m-%d %H:%M:%S", systime(), 1), $0; system("") }'
fi
