#!/bin/bash

dashboard_queue_len=$(redis-cli -n 4 -a your-passwd -h localhost llen app:logstash_java)

echo $dashboard_queue_len
if ((dashboard_queue_len < 500)); then
    echo 'ok'
    exit 0
elif ((dashboard_queue_len > 500 && dashboard_queue_len < 1000)); then
    echo 'warning'
    exit 1
elif ((dashboard_queue_len > 1000)); then
    echo 'critical'
    exit 2
else
    echo 'unknown'
    exit 3
fi
