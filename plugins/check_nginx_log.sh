#!/bin/bash

log="/data/log/nginx/appstore_error.log"
modify_time=$(( ( ($(date +%s) - $(stat -c '%Y' "$log")) / 60 ) ))

if [ ! -f "$log" ] || [ "$(stat -c '%s' $log 2>/dev/null)" = 0 ]; then
    echo "OK. Can not find $log"
    exit 0
elif (( modify_time >= 30 )); then
    echo "error happend in last $modify_time minutes."
    exit 0
elif (( modify_time >= 5 )); then
    echo "error happend in last $modify_time minutes."
    tail "$log"
    exit 1
elif (( modify_time < 5 )); then
    echo "error happend in last $modify_time minutes."
    tail "$log"
    exit 2
fi
