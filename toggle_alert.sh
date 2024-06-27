#!/bin/bash

if [ "$1" == "start" ]; then
    sed -i 's/$not_alert/0/g' /etc/nginx/conf.d/default.conf
elif [ "$1" == "stop" ]; then
    sed -i 's/$not_alert/1/g' /etc/nginx/conf.d/default.conf
fi

nginx -s reload
