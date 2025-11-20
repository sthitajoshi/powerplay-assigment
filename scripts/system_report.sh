#!/usr/bin/env bash

LOG_FILE="/var/log/system_report.log"

{
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

  DISK_USAGE_NUM=$(echo "$DISK_USAGE" | tr -d '%')

  # Disk alert if > 80%
  if [ "$DISK_USAGE_NUM" -gt 80 ]; then
    echo "Disk usage alert: $DISK_USAGE on $(hostname) at $(date)"
  fi

  echo
  echo "Top 3 Processes by CPU:"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4

  echo
} >> "$LOG_FILE"

*Make the file executable:*
sudo chmod +x /usr/local/bin/system_report.sh


* after 5 min *
sudo crontab -e

