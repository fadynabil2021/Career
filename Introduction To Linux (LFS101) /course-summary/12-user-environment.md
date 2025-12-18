# 12. User Environment

## Learning Objectives

- Manage user accounts, groups, and permissions.
- Understand environment variables and shell history.

## Key Concepts Explained

- **Accounts, Users & Groups**
  - /etc/passwd, /etc/group, home directories, UID/GID, sudoers.
  - Role-based access using groups (e.g., wheel, sudo, www-data).

- **Environment Variables**
  - PATH, HOME, SHELL, and how they influence process behavior.

- **File Permissions**
  - rwx for user/group/others, sticky bit, setuid/setgid semantics.

## Commands & Examples

```bash
# Add user and create home
sudo useradd -m -s /bin/bash alice
sudo passwd alice

# Add user to group
sudo usermod -aG sudo alice

# Check permissions
ls -l /var/www
```

## Real-World Usage Scenarios

- Creating a limited account for an intern and restricting file access via groups.
- Using environment files to set PATH for user-installed tools.

## Common Mistakes & Best Practices

- Mistake: Giving sudo privileges to regular users unnecessarily.
- Best practice: Follow least-privilege principle and use groups to manage access.

## Summary

User and group management, along with correct permissions and environment variables, underpin a secure multi-user system.
