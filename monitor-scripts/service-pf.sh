#!/bin/bash

bobcatVersion=$(cat /etc/bobcat-version | tr -d "\n")

case "$bobcatVersion" in
    29* | 285)
        status=$(cat /var/dashboard/services/PF | tr -d "\n")

        if [[ $status == 'stop' ]]; then
            docker stop pktfwd
            echo 'disabled' > /var/dashboard/services/PF
        elif [[ $status == 'start' ]]; then
            docker start pktfwd
            echo 'starting' > /var/dashboard/services/PF
        elif [[ $status == 'starting' ]]; then
            pid=$(docker ps -q --filter "name=pktfwd")
            if [[ $pid ]]; then
                echo 'running' > /var/dashboard/services/PF
            fi
        fi
        ;;

    280)
        status=$(cat /var/dashboard/services/PF | tr -d "\n")

        if [[ $status == 'stop' ]]; then
            systemctl stop lora-pkt-fwd.service
            echo 'disabled' > /var/dashboard/services/PF
        elif [[ $status == 'start' ]]; then
            systemctl start lora-pkt-fwd.service
            echo 'starting' > /var/dashboard/services/PF
        elif [[ $status == 'starting' ]]; then
            pid=$(pgrep lora_pkt_)
            if [[ $pid ]]; then
                echo 'running' > /var/dashboard/services/PF
            fi
        fi
        ;;

    *)
        echo "Unsupported bobcat version: $bobcatVersion"
        ;;
esac
