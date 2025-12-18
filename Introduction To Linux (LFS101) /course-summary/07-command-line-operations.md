
# 07. Command Line Operations

## Learning Objectives

* Use core shell utilities for file and system operations.
* Understand shell modes and how to operate a headless system.

## Key Concepts Explained

* **Shell Modes**: interactive vs non-interactive; login shells vs non-login.
* **Basic Operations**: navigation (cd, ls), file manipulation (cp, mv, rm), file viewing (cat, less).

## Commands & Examples

```bash
# List files with human-readable sizes
ls -lah

# Copy a directory recursively
cp -a /source/dir /dest/dir

# Find files by name
find /var -type f -name "*.log"
```

## Real-World Usage Scenarios

* Using SSH to manage remote servers without a GUI.
* Scripting repetitive tasks with shell commands.

## Common Mistakes & Best Practices

* Mistake: Using `rm -rf` without confirming path.
* Best practice: Use `--preserve-root` and test destructive commands in a safe environment.

## Summary

The command line is the most powerful interface in Linux. Mastery of core utilities enables efficient system administration and automation.


