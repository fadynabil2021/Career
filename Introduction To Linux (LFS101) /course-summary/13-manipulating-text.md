# 13. Manipulating Text

## Learning Objectives

- Use tools like sed, awk, grep, cut, and sort to process text data.
- Build pipelines to transform and extract data from logs and files.

## Key Concepts Explained

- **Text Processing Tools**
  - `grep`: search by pattern, `sed`: stream editing, `awk`: field-aware scripting, `cut`, `sort`, `uniq`.
  - Why it matters: logs and system outputs are text — mastering these tools makes data actionable.

## Commands & Examples

```bash
# Find lines with error and show surrounding context
grep -n -C2 "ERROR" /var/log/syslog

# Extract 1st column and sort unique values
awk '{print $1}' access.log | sort | uniq -c | sort -nr

# Replace a string in a file
sed -i 's/old.example.com/new.example.com/g' /etc/hosts
```

## Real-World Usage Scenarios

- Summarizing web server access logs to find top client IPs.
- Using sed/awk in maintenance scripts to update configuration templates.

## Common Mistakes & Best Practices

- Mistake: Using `sed -i` without backups.
- Best practice: Test expressions and use `-n` or dry-run before in-place edits.

## Summary

Text tools are the core of UNIX philosophy — small programs combined into pipelines solve complex problems with brevity and power.
