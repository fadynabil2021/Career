
# 05. System Configuration (GUI)

## Learning Objectives

* Perform common system configuration tasks via graphical tools.
* Manage display, time, network, and software updates from a desktop environment.

## Key Concepts Explained

* **System Settings**

  * Display settings, date/time, user accounts.
  * Network Manager provides GUI controls for wired/wireless connections.

* **Software Management**

  * GUI package managers (GNOME Software, Discover) wrap lower-level package tools.

## Commands & Examples

```bash
# Network status via nmcli
nmcli device status

# Install package via apt (GUI is wrapper over this)
sudo apt update && sudo apt install <package>
```

## Real-World Usage Scenarios

* Setting up Wi-Fi on a laptop via Network Manager applet.
* Installing popular applications from the GUI store for non-technical users.

## Common Mistakes & Best Practices

* Mistake: Relying solely on GUI for system administration; GUIs may hide important options.
* Best practice: Learn equivalent CLI commands for repeatable automation.

## Summary

GUI tools simplify administration for many tasks; however, pairing GUI workflows with CLI knowledge leads to more reliable and automatable system management.


