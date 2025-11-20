#!/usr/bin/env bash

echo "========== System Report: $(date) =========="

echo "Uptime:"
uptime

echo
echo "CPU Usage (%):"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "$CPU_USAGE"

echo
echo "Memory Usage (%):"
MEM_USAGE=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
echo "$MEM_USAGE"

echo
echo "Disk Usage (%):"
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "$DISK_USAGE"

# Convert "85%" -> 85
DISK_USAGE_NUM=$(echo "$DISK_USAGE" | tr -d '%')

# Alert if >80%
if [ "$DISK_USAGE_NUM" -gt 80 ]; then
  ALERT_MSG="Disk usage alert: $DISK_USAGE on $(hostname) at $(date)"
  echo "$ALERT_MSG" >> /var/log/system_report.log

  # Optional: send email using AWS SES (requires configuration)
  # aws ses send-email \
  #   --region ap-south-1 \
  #   --from "your-email@example.com" \
  #   --destination "ToAddresses=your-email@example.com" \
  #   --message "Subject={Data=Disk usage Alert},Body={Text={Data=$ALERT_MSG}}"

  # Optional: if 'mail' is configured
  # echo "$ALERT_MSG" | mail -s "Disk Usage Alert" your-email@example.com
fi
