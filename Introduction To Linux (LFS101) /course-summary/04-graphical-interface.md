
# File: 04-graphical-interface.md

# 04. Graphical Interface

## Learning Objectives

* Understand the components of a Linux graphical environment.
* Manage sessions and basic GUI troubleshooting.

## Key Concepts Explained

* **Display Server & Compositors**

  * X11 vs Wayland: roles in handling input/output between applications and hardware.
  * Desktop environments (GNOME, KDE): provide session management and integrated apps.

* **Session Management**

  * Display manager (gdm, sddm, lightdm) handles login; session managers restore user sessions.

## Commands & Examples

```bash
# Check if Xorg is running
ps aux | grep -E "X|wayland" | grep -v grep

# Restart display manager (systemd)
sudo systemctl restart gdm.service
```

## Real-World Usage Scenarios

* Switching from X to Wayland due to better security/isolation.
* Restarting a hung desktop session without rebooting the machine.

## Common Mistakes & Best Practices

* Mistake: Killing the wrong process; may terminate the whole graphical session.
* Best practice: Use TTY (Ctrl+Alt+F3) to diagnose GUI problems.

## Diagrams & Assets

2. GUI Stack

```
![Graphical Stack](../assets/summary/04-gui-stack.png)
```

Description: Hardware → Kernel → Display server → Compositor → Desktop environment.

## Summary

Graphical interfaces are layered systems; knowing how the stack fits together helps in troubleshooting and optimizing desktop experience.


