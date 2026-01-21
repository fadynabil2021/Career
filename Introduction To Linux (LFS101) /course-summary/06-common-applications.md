# 06. Common Applications

## Learning Objectives

* Identify common categories of desktop applications and their use-cases.
* Recognize development and multimedia tools typically available on Linux.

## Key Concepts Explained

* **Internet Applications**: browsers, email clients, chat apps -- integration with system keyrings and proxies.
* **Productivity & Development Applications**: office suites, IDEs, editors, package managers.
* **Multimedia & Graphics**: players, encoders, editors (GIMP, Inkscape).

## Commands & Examples

```bash
# Launch a GUI application from terminal
firefox &

# Install developer tools
sudo apt install build-essential git
```

## Real-World Usage Scenarios

* Setting up a development environment with VSCode, Git, and container tools.
* Converting media with ffmpeg for cross-platform sharing.

## Common Mistakes & Best Practices

* Mistake: Installing too many GUI apps system-wide instead of using containers or Flatpak.
* Best practice: Use sandboxed packaging (Flatpak, Snap) for untrusted GUI apps.

## Summary

Linux offers mature desktop applications for most needs; choosing packaging models and understanding integration points improves system hygiene and security.

---

# File: 07-command-line-operations.md

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


