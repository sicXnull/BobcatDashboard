
bobcatVersion=$(cat /etc/bobcat-version | tr -d "\n")


if [[ "$bobcatVersion" == 29* || "$bobcatVersion" == 285 ]]; then
    
    status=$(cat /var/dashboard/services/PF | tr -d "\n")

    if [[ $status == 'stop' ]]; then
        docker stop pktfwd
        echo 'disabled' > /var/dashboard/services/PF
    fi

    if [[ $status == 'start' ]]; then
        docker start pktfwd
        echo 'starting' > /var/dashboard/services/PF
    fi

    if [[ $status == 'starting' ]]; then
        pid=$(docker ps -q --filter "name=pktfwd")
        if [[ $pid ]]; then
            echo 'running' > /var/dashboard/services/PF
        fi


elif [[ "$bobcatVersion" == 280 ]]; then
    
    status=$(cat /var/dashboard/services/PF | tr -d "\n")

    if [[ $status == 'stop' ]]; then
        docker stop pktfwd
        echo 'disabled' > /var/dashboard/services/PF
    fi

    if [[ $status == 'start' ]]; then
        docker start pktfwd
        echo 'starting' > /var/dashboard/services/PF
    fi

    if [[ $status == 'starting' ]]; then
        pid=$(docker ps -q --filter "name=pktfwd")
        if [[ $pid ]]; then
            echo 'running' > /var/dashboard/services/PF
        fi
    fi
else
    echo "Unsupported bobcat version: $bobcatVersion"
fi
