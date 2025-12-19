#!/usr/bin/env bash
# Purpose: create a concise weekly audit of system logs
# Usage: log-audit.sh [--since days]

set -euo pipefail

SINCE_DAYS=7
OUT_DIR="/var/log/company/audit"
mkdir -p "$OUT_DIR"

if [ "${1:-}" = "--help" ]; then
  cat <<'EOF'
Usage: log-audit.sh [--since N]
Generates a set of grep-filtered summaries from journalctl and selected log files.
EOF
  exit 0
fi

if [ "${1:-}" = "--since" ] && [ -n "${2:-}" ]; then
  SINCE_DAYS="$2"
fi

SINCE="${SINCE_DAYS} days ago"
report="$OUT_DIR/audit-$(date --utc +%F).txt"

{
  echo "Audit generated: $(date --utc +%FT%TZ)"
  echo "Since: $SINCE"
  echo
  echo "---- System errors (journalctl -p 3) ----"
  journalctl -p 3 --since "$SINCE" -n 200 || true
  echo
  echo "---- Authentication failures (sshd) ----"
  journalctl -u ssh --since "$SINCE" | grep -i "failed\|invalid" -n || true
  echo
  echo "---- Disk warnings ----"
  journalctl --since "$SINCE" | grep -i 'disk' -n || true
  echo
  echo "---- Application (nginx) errors ----"
  journalctl -u nginx --since "$SINCE" -n 200 || true
} > "$report"

echo "Audit written to $report"
