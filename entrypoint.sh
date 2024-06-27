#!/bin/bash

# Read environment variables
ALERT_DAY=${ALERT_DAY:-Friday}
ALERT_TIME=${ALERT_TIME:-11:45}
ALERT_DURATION=${ALERT_DURATION:-5}

# Prepare the cron job string
START_TIME="${ALERT_TIME:3:2} ${ALERT_TIME:0:2} * * $(date -d $ALERT_DAY +%u)"
END_TIME=$(date -d "$ALERT_TIME $ALERT_DURATION minutes" +"%M %H * * %u")

# Add cron job to switch alert on
echo "$START_TIME root /usr/local/bin/toggle_alert.sh start" > /etc/cron.d/probealarm-cron

# Add cron job to switch alert off
echo "$END_TIME root /usr/local/bin/toggle_alert.sh stop" >> /etc/cron.d/probealarm-cron

# Apply cron job
crontab /etc/cron.d/probealarm-cron

# Start cron service
cron

# Start Nginx
nginx -g 'daemon off;'
