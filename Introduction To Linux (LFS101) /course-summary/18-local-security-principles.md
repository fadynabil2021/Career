# 18. Local Security Principles

## Learning Objectives

- Apply basic security hygiene for local Linux systems.
- Understand when to use root privileges and how to limit exposure.

## Key Concepts Explained

- **Root & Privilege Management**
  - Root account vs sudo: delegation, auditability, and least privilege.

- **Process Isolation & Updates**
  - Containers, apparmor/SELinux, and keeping systems up to date to minimize vulnerability exposure.

- **Passwords & Authentication**
  - Strong password policies, PAM configuration, and multi-factor authentication where available.

- **Boot & Hardware Security**
  - Secure boot, encrypted disks, and physical access controls.

## Commands & Examples

```bash
# Check for available security updates (Debian/Ubuntu)
sudo apt update && apt list --upgradable

# Lock an account
sudo passwd -l alice

# View sudoers file safely
sudo visudo
```

## Real-World Usage Scenarios

- Hardening a workstation by enabling full-disk encryption and configuring automatic updates.
- Using sudoers to limit commands available to support staff.

## Common Mistakes & Best Practices

- Mistake: Using root shell for routine tasks.
- Best practice: Use fine-grained sudo rules, enable audit logging, and minimize attack surface by disabling unnecessary services.

## Diagrams & Assets

5. Security Layers
```
![Security Layers](../assets/summary/18-security-layers.png)
```
Description: Physical → Firmware → Kernel → Services → Application hardening.

## Summary

Local security is layered: control physical access, limit privileges, patch promptly, and use OS-level isolation for added safety.
