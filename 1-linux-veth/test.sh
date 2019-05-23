#!/usr/bin/env bash

set -e

function check_error {
    if [ "$?" -ne 0 ]; then
        echo " - ***** FAILED *****"
    else
        echo " - PASSED"
    fi
}

echo -n "Checking connectivity from host to NS1"
ping -W 1 -c 1 192.168.10.20 > /dev/null 2>&1
check_error

echo -n "Checking connectivity from NS1 to host"
sudo ip netns exec NS1 ping -W 1 -c 1 192.168.10.10 > /dev/null 2>&1
check_error
