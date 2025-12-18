# 14. Network Operations

## Learning Objectives

- Understand IP addressing, DNS, and common network troubleshooting tools.
- Manage networking configuration and transfer files between systems.

## Key Concepts Explained

- **Network Addresses and DNS**
  - IP (v4/v6), subnetting basics, default gateway, nameservers.

- **Configuration & Tools**
  - `ip`, `ifconfig` (legacy), `nmcli`, `ss`, `netstat` (legacy), `ping`, `traceroute`, `dig`/`nslookup`.

- **File Transfer**
  - `scp`, `rsync`, `sftp`, `curl`, `wget`.

## Commands & Examples

```bash
# Show IP addresses
ip addr show

# Test DNS resolution
dig example.com +short

# Check open ports and listening services
ss -tuln

# Copy a file to remote server
scp file.tar user@host:/tmp/
```

## Real-World Usage Scenarios

- Diagnosing connectivity issues using ping and traceroute.
- Migrating files between servers using rsync over ssh.

## Common Mistakes & Best Practices

- Mistake: Exposing services on public interfaces inadvertently.
- Best practice: Use firewalls (ufw, nftables) and bind services to localhost when appropriate.

## Diagrams & Assets

4. Network Layers Overview
```
![Network Layers](../assets/summary/14-network-layers.png)
```
Description: Link between application tools and underlying IP/routing concepts.

## Summary

Network literacy — understanding addressing, DNS, and tools — is essential for connectivity, security, and service availability.
