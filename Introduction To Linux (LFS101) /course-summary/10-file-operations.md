

# 10. File Operations

## Learning Objectives

* Understand filesystems, layout, and common file operations.
* Perform backups and compression for data protection.

## Key Concepts Explained

* **Filesystems & Layout**

  * Types (ext4, xfs, btrfs), mounting, and `/etc/fstab`.
  * Standard directories and their purposes (e.g., `/var` for variable data).

* **Backing Up & Compression**

  * Tools: tar, gzip, bzip2, rsync.
  * Why it matters: data integrity and disaster recovery.

## Commands & Examples

```bash
# Check disk usage and free space
df -h

# Create a compressed tarball
tar -czvf backup-2025-01-01.tar.gz /home/user

# Efficient sync backup
rsync -a --delete /source/ /backup/
```

## Real-World Usage Scenarios

* Creating incremental backups using rsync and cron.
* Resizing or repairing filesystems in maintenance windows.

## Common Mistakes & Best Practices

* Mistake: Relying solely on a single backup stored on the same disk.
* Best practice: Use offsite backups, verify backups (test restores), and document backup procedures.

## Summary

Proper file operations and backup strategies are foundational for protecting data and ensuring system continuity.



# Document End
