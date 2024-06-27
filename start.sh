#!/bin/sh

# Set variables for the alarm time and duration
ALARM_DAY=${ALARM_DAY}
ALARM_TIME=${ALARM_TIME}
ALARM_DURATION=${ALARM_DURATION}

# Calculate the end time of the alarm
ALARM_END=$(date -d "${ALARM_TIME} today +${ALARM_DURATION} minutes" +%H:%M)

# Check the current time and day to see if the alarm should be active
CURRENT_DAY=$(date +%A)
CURRENT_TIME=$(date +%H:%M)

if [ "$CURRENT_DAY" = "$ALARM_DAY" ] && [ "$CURRENT_TIME" \> "$ALARM_TIME" ] && [ "$CURRENT_TIME" \< "$ALARM_END" ]; then
    ln -sf /etc/nginx/conf.d/alert.conf /etc/nginx/conf.d/dynamic.conf
else
    ln -sf /etc/nginx/conf.d/no_alert.conf /etc/nginx/conf.d/dynamic.conf
fi

# Start Nginx
nginx -g "daemon off;"
