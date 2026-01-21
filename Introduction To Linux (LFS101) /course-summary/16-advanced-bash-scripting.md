# 16. Advanced Bash Scripting

## Learning Objectives

- Perform string manipulation, structured looping, and debugging of complex scripts.
- Use functions and the case statement to build modular scripts.

## Key Concepts Explained

- **String Manipulation**
  - Parameter expansion, substring extraction, trimming, pattern replacement.

- **Looping & Case**
  - `for`, `while`, `until`, and `case` for structured flow.

- **Debugging**
  - `set -x`, using `trap` for cleanup, logging strategies.

## Commands & Examples

```bash
# Example function and case usage
backup() {
  src="$1"
  dest="$2"
  rsync -a "$src/" "$dest/"
}

case "$1" in
  daily)
    backup "/home/user" "/backup/daily" ;;
  weekly)
    backup "/home/user" "/backup/weekly" ;;
  *)
    echo "Usage: $0 {daily|weekly}" ; exit 2 ;;
esac
```

## Real-World Usage Scenarios

- Building reliable maintenance scripts with argument parsing and logging.
- Using traps to ensure temporary files are cleaned on exit.

## Common Mistakes & Best Practices

- Mistake: Reinventing complex parsing instead of using utilities like `getopts`.
- Best practice: Keep scripts small, modular, and documented; prefer Python or system tools for heavy logic.

## Summary

Advanced scripting turns ad-hoc commands into reusable tools; apply defensive coding and modular design for maintainability.
