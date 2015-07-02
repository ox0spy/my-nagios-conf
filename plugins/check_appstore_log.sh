#!/bin/bash

appstore_error_log="/data/log/appstore/appstore_error.log"
modify_time=$(( ( ($(date +%s) - $(stat -c '%Y' "$appstore_error_log")) / 60 ) ))

if [ ! -f "$appstore_error_log" ] || [ "$(stat -c '%s' $appstore_error_log 2>/dev/null)" = 0 ]; then
    echo "OK. Can not find $appstore_error_log"
    exit 0
elif (( modify_time >= 30 )); then
    echo "error happend in last $modify_time minutes."
    exit 0
elif (( modify_time >= 5 )); then
    echo "error happend in last $modify_time minutes."
    tail "$appstore_error_log"
    exit 1
elif (( modify_time < 5 )); then
    echo "error happend in last $modify_time minutes."
    tail "$appstore_error_log"
    exit 2
fi
