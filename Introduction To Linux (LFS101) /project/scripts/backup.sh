#!/usr/bin/env bash
# Purpose: create dated rsync backups of important directories to a local backup mount
# Usage: backup.sh [--dry-run]
# Idempotent, logs to /var/log/company/backup.log

set -euo pipefail

DRY_RUN=false
LOG_DIR="/var/log/company"
BACKUP_ROOT="/backups"
RETENTION_DAYS=7
SRC_DIRS=("/home" "/srv/files" "/opt/company-tools")

for arg in "${@:-}"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -h|--help)
      cat <<'EOF'
Usage: backup.sh [--dry-run]
Creates a compressed rsync-style backup of selected directories.
--dry-run  : Do not perform changes; show what would happen.
EOF
      exit 0 ;;
    *) echo "Unknown arg: $arg" >&2; exit 2 ;;
  esac
done

mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_ROOT"

TIMESTAMP=$(date --utc +%F_%H%M%SZ)
DEST="$BACKUP_ROOT/backup-$TIMESTAMP"

log() { printf '%s %s\n' "$(date --utc +%FT%TZ)" "$*" >> "$LOG_DIR/backup.log"; }

if [ "$DRY_RUN" = true ]; then
  echo "DRY RUN: would create $DEST"
  for d in "${SRC_DIRS[@]}"; do
    echo "Would rsync $d -> $DEST/$(basename "$d")"
  done
  exit 0
fi

log "Starting backup to $DEST"
mkdir -p "$DEST"

for d in "${SRC_DIRS[@]}"; do
  if [ -d "$d" ]; then
    rsync -a --delete --numeric-ids --link-dest="$BACKUP_ROOT/latest" "$d/" "$DEST/$(basename "$d")/"
    log "Backed up $d"
  else
    log "Skipped missing source $d"
  fi
done

# Update 'latest' symlink atomically
tmpdir=$(mktemp -d --tmpdir "backup-tmp.XXXX")
ln -sfn "$DEST" "$tmpdir/latest"
mv -T "$tmpdir/latest" "$BACKUP_ROOT/latest"
rm -rf "$tmpdir"

# Prune older backups
find "$BACKUP_ROOT" -maxdepth 1 -type d -name 'backup-*' -mtime +$RETENTION_DAYS -print0 | xargs -0 -r rm -rf

log "Backup completed: $DEST"
echo "Backup completed: $DEST"


