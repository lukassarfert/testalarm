# Start from the official Nginx image
FROM nginx:alpine

# Copy the custom configuration file for Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the script to the container
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the environment variables for the alarm time and duration
ENV ALARM_DAY=Friday
ENV ALARM_TIME=11:45
ENV ALARM_DURATION=5

# Run the custom start script
CMD ["/start.sh"]
