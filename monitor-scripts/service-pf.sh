#!/bin/bash
status=$(</var/dashboard/services/PF)

if [[ $status == 'stop' ]]; then
  sudo docker stop pktfwd
  echo 'stopping' > /var/dashboard/services/PF
fi

if [[ $status == 'start' ]]; then
  sudo docker start pktfwd
  echo 'starting' > /var/dashboard/services/PF
fi

if [[ $status == 'starting' ]]; then
  miner_status=$(sudo docker inspect --format "{{.State.Running}}" pktfwd)
  if [[ $miner_status == true ]]; then
    echo 'running' > /var/dashboard/services/PF
  fi
fi

if [[ $status == 'stopping' ]]; then
  miner_status=$(sudo docker inspect --format "{{.State.Running}}" pktfwd)
  if [[ $miner_status == false ]]; then
    echo 'disabled' > /var/dashboard/services/PF
  fi
fi
