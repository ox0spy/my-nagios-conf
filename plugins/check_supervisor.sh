#!/bin/bash

res=$(/usr/bin/supervisorctl -c /etc/supervisor/supervisord.conf status)

if echo "$res" | grep -qE 'EXITED|BACKOFF|FATAL|UNKNOWN'; then
    echo "$res" | grep -E 'EXITED|BACKOFF|FATAL|UNKNOWN'
    exit 2
elif echo "$res" | grep -qE 'STOPPED|STOPPING|STARTING'; then
    echo "$res" | grep -E 'STOPPED|STOPPING|STARTING'
    exit 1
elif test -z "$(echo \"$res\" | grep -Ev 'RUNNING')"; then
    echo "all processes running."
    exit 0
else
    echo "$res"
    exit 3
fi
