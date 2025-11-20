Great — here is your **FULL, CLEAN, POLISHED `README.md`** containing **Part 1 to Part 5**, perfectly structured for your DevOps Intern assignment.

Your uploaded screenshot is inserted automatically in **Part 1**.
Other screenshots will be added once you upload them.

---

# ✅ **FINAL README.md (Complete DevOps Assignment)**

````markdown
# DevOps Intern Assignment – AWS EC2, Nginx, Monitoring & CloudWatch

This project demonstrates essential DevOps tasks on an AWS EC2 Ubuntu instance, including user setup, hostname configuration, Nginx deployment, system monitoring automation, and CloudWatch log integration.

---

# 📌 Part 1 – Environment Setup

## 1. Launch EC2 Instance
- Region: **ap-south-1** (Mumbai)  
- Type: **t2.micro**  
- OS: **Ubuntu 24.04 LTS**  
- Inbound rules: SSH (22), HTTP (80)

Connect to the instance:

```bash
ssh -i powerplay.pem ubuntu@<PUBLIC_IP>
````

---

## 2. Create New User

```bash
sudo adduser devops_intern
```

Add to sudo group:

```bash
sudo usermod -aG sudo devops_intern
```

---

## 3. Enable Passwordless sudo

```bash
echo "devops_intern ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/devops_intern
sudo chmod 440 /etc/sudoers.d/devops_intern
```

---

## 4. Change Hostname

```bash
sudo hostnamectl set-hostname sthita-devops
```

---

## 5. Switch to New User

```bash
su - devops_intern
```

---

## 6. Verify Configuration

Check hostname:

```bash
hostname
# expected: sthita-devops
```

Verify entry in passwd:

```bash
grep devops_intern /etc/passwd
```

Verify passwordless sudo:

```bash
sudo whoami
# expected: root
```

---

## 7. Screenshot – Verification

Screenshot shows:

* Hostname = sthita-devops
* grep output
* sudo whoami = root

### Embedded Screenshot

![Part 1 – Hostname and sudo verification](sandbox:/mnt/data/part%201.jpg)

---

# 📌 Part 2 – Nginx Setup & Custom Web Page

## 1. Install Nginx

```bash
sudo apt update
sudo apt install -y nginx
```

---

## 2. Fetch Metadata for Web Page

```bash
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
UPTIME=$(uptime -p)
```

---

## 3. Create Custom Status Page

```bash
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>DevOps Intern Status Page</title>
</head>
<body>
  <h1>DevOps Intern – Status Page</h1>
  <p><strong>Name:</strong> Sthita Joshi</p>
  <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
  <p><strong>Server Uptime:</strong> $UPTIME</p>
</body>
</html>
EOF
```

---

## 4. Screenshot (to be added)

```
screenshots/
└── part2-nginx-status.png
```

Embed later:

```markdown
![Part 2 – Nginx Custom Page](screenshots/part2-nginx-status.png)
```

---

# 📌 Part 3 – Monitoring Script & Cron Automation

## 1. Create Script

`/usr/local/bin/system_report.sh`

```bash
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

  if [ "$DISK_USAGE_NUM" -gt 80 ]; then
    echo "Disk usage alert: $DISK_USAGE on $(hostname) at $(date)"
  fi

  echo
  echo "Top 3 Processes by CPU:"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4
  echo
} >> "$LOG_FILE"
```

Make script executable:

```bash
sudo chmod +x /usr/local/bin/system_report.sh
```

---

## 2. Schedule via Cron (every 5 min)

```bash
sudo crontab -e
```

Add:

```cron
*/5 * * * * /usr/local/bin/system_report.sh
```

---

## 3. Screenshot Placeholder

```
screenshots/
└── part3-system-log.png
```

Embed:

```markdown
![Part 3 – System Report Logs](screenshots/part3-system-log.png)
```

---

# 📌 Part 4 – Push Logs to CloudWatch

## 1. Install AWS CLI

```bash
sudo apt install -y awscli
```

Configure:

```bash
aws configure
```

---

## 2. Create Log Group & Stream

```bash
aws logs create-log-group --log-group-name /devops/intern-metrics
```

```bash
aws logs create-log-stream \
  --log-group-name /devops/intern-metrics \
  --log-stream-name sthita-devops-system-report
```

---

## 3. Push Log File Content

(Example)

```bash
aws logs put-log-events \
  --log-group-name /devops/intern-metrics \
  --log-stream-name sthita-devops-system-report \
  --log-events file://log-events.json
```

---

## 4. Screenshot Placeholder

```
screenshots/
└── part4-cloudwatch.png
```

Embed:

```markdown
![Part 4 – CloudWatch Log Stream](screenshots/part4-cloudwatch.png)
```

---

# 📌 Part 5 – Documentation & Cleanup

## How to Reproduce

1. Launch EC2
2. Create user
3. Install Nginx
4. Deploy custom webpage
5. Create monitoring script
6. Schedule cron job
7. Push logs to CloudWatch

---

## Cleanup

Terminate EC2 instance to avoid charges:

```bash
aws ec2 terminate-instances --instance-ids <ID>
```

Optional: remove CloudWatch group

```bash
aws logs delete-log-group --log-group-name /devops/intern-metrics
```

---

# 📁 Project Structure

```
.
├── README.md
├── scripts/
│   └── system_report.sh
└── screenshots/
    ├── part1-verification.png
    ├── part2-nginx-status.png
    ├── part3-system-log.png
    └── part4-cloudwatch.png
```

---

# 🎉 End of Assignment

This README fully documents your DevOps Intern task, end-to-end.

```

---

### ✅ **Your README is now complete.**

Now just upload the remaining screenshots (Part 2, Part 3, Part 4), and I will insert them into the correct places.
```
