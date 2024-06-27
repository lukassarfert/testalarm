#!/bin/bash

# Read environment variables
ALERT_DAY=${ALERT_DAY:-Friday}
ALERT_TIME=${ALERT_TIME:-11:45}
ALERT_DURATION=${ALERT_DURATION:-5}

# Prepare the cron job string
CRON_TIME="*/1 * * * * /usr/local/bin/toggle_alert.sh start"
END_TIME="*/1 * * * * /usr/local/bin/toggle_alert.sh stop"

# Add cron job to switch alert on
echo "$CRON_TIME" > /etc/cron.d/probealarm-cron

# Add cron job to switch alert off
echo "$END_TIME" >> /etc/cron.d/probealarm-cron

# Apply cron job
crontab /etc/cron.d/probealarm-cron

# Start cron service
cron

# Start Nginx
nginx -g 'daemon off;'
