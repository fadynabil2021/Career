# Step-by-Step Setup

## 1. Base System Installation

- Install Ubuntu/Fedora-like distribution
- Create admin user and enable disk encryption

## 2. Filesystem & Directory Layout

```bash
sudo mkdir -p /opt/company-tools /var/log/company /backups
sudo chown -R admin:admin /opt/company-tools /backups
chmod 750 /opt/company-tools
```

## 3. Users & Groups

```bash
groupadd admin
groupadd analyst
useradd -m -G admin fady
usermod -aG sudo fady
```

## 4. Service Installation & Management

```bash
sudo apt install nginx samba rsync
sudo systemctl enable --now nginx ssh
```

## 5. Networking

```bash
ip a
ss -tuln
sudo ufw allow ssh
sudo ufw allow http
sudo ufw enable
```

## 6. Scripts & Automation

- Place scripts in `/usr/local/bin` or `/opt/company-tools`
- Include logging, strict mode, error handling
- Examples:
  - `backup.sh`
  - `system-health-check.sh`
  - `log-audit.sh`

## 7. Security Hardening

- Disable root login over SSH
- Enforce key-based authentication
- Apply least privilege principles
- Automatic security updates enabled
