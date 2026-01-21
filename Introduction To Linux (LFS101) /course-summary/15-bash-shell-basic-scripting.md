# 15. Bash Shell and Basic Scripting

## Learning Objectives

- Write simple shell scripts and understand shell syntax.
- Use variables, conditionals, and basic I/O in scripts.

## Key Concepts Explained

- **Bash Basics**
  - Shebang (`#!/bin/bash`), variables, quoting, command substitution, exit codes.

- **Control Structures**
  - `if`, `for`, `while`, `case`.

## Commands & Examples

```bash
# Simple script example
cat > ~/scripts/backup.sh <<'EOF'
#!/bin/bash
set -euo pipefail

src="$HOME/data"
dest="/backup/$(date +%F)"

mkdir -p "$dest"
rsync -a "$src/" "$dest/"
EOF

chmod +x ~/scripts/backup.sh

# Run it
~/scripts/backup.sh
```

## Real-World Usage Scenarios

- Automating periodic backups and maintenance tasks with cron or systemd timers.
- Quick orchestration of local utilities for admin jobs.

## Common Mistakes & Best Practices

- Mistake: Not handling errors or quoting variables — leads to failures and word-splitting bugs.
- Best practice: Use `set -euo pipefail` and quote variables consistently.

## Summary

Bash scripting allows automation of mundane tasks; robust scripts follow defensive practices and clear structure.
