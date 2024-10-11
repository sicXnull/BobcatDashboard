#!/bin/bash
docker logs -f pktfwd 2>&1 | grep -E 'rxpk|txpk' --line-buffered | gawk '{ print strftime("%Y-%m-%d %H:%M:%S",systime(),1), $0; system("") }'
