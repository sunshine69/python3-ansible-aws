#!/bin/sh

DURATION=${1:-7200}

die_func() {
        echo "oh no"
        sleep 2
        exit 1
}
trap die_func TERM

echo "sleeping"
sleep $DURATION &
wait
