# System Architecture

## Layered Design

1. **Hardware & Firmware**: Physical or virtual system with BIOS/UEFI.
2. **Boot & Kernel Layer**: GRUB bootloader, Linux kernel, initramfs.
3. **System Services Layer**: systemd, sshd, logging, timers.
4. **Application Services Layer**: nginx (web), Samba/Nextcloud (file sharing), maintenance scripts.
5. **User Interaction Layer**: Local shell or SSH, role-based access.
6. **Monitoring & Logging Layer**: Logs for health, disk, and services.

## Diagram Reference

```
![System Architecture](../assets/project/system-architecture.png)
```

## Design Decisions

- Single-node scope simplifies demonstration while covering all essential Linux concepts
- systemd-centric management reflects modern best practices
- Automation and logging emphasize production-readiness
- Strict role-based access demonstrates security principles
