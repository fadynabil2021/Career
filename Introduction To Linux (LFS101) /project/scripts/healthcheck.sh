#!/usr/bin/env bash
# Purpose: perform a set of health checks and exit non-zero on failure
# Usage: healthcheck.sh

set -euo pipefail

LOG_DIR="/var/log/company"
mkdir -p "$LOG_DIR"
logfile="$LOG_DIR/healthcheck.log"

log() { printf '%s %s\n' "$(date --utc +%FT%TZ)" "$*" >> "$logfile"; }

check_service() {
  local unit="$1"
  if systemctl is-active --quiet "$unit"; then
    log "OK: $unit is active"
  else
    log "FAIL: $unit is not active"
    return 2
  fi
}

check_disk() {
  local path="$1" threshold="$2"
  usage=$(df -P "$path" | awk 'NR==2{gsub(/%/,"",$5); print $5}')
  if [ "$usage" -ge "$threshold" ]; then
    log "FAIL: $path usage ${usage}% >= ${threshold}%"
    return 3
  else
    log "OK: $path usage ${usage}% < ${threshold}%"
  fi
}

main() {
  local rc=0
  check_service ssh || rc=$((rc+1))
  check_service nginx || rc=$((rc+2))
  check_disk / 85 || rc=$((rc+4))
  if [ "$rc" -eq 0 ]; then
    log "Health OK"
  else
    log "Health checks failed (code $rc)"
  fi
  return $rc
}

main
