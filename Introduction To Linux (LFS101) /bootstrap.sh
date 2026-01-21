#!/usr/bin/env bash
# bootstrap.sh - install project scripts, systemd units, and assets to host
# Usage: sudo ./bootstrap.sh [--dry-run]
set -euo pipefail

DRY_RUN=false
REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)
SCRIPTS_SRC="$REPO_ROOT/project/scripts"
SCRIPTS_DST="/usr/local/bin"
SYSTEMD_DST="/etc/systemd/system"
LOG_DIR="/var/log/company"
BACKUP_DIR="/backups"

for arg in "${@:-}"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -h|--help)
      cat <<'EOF'
Usage: bootstrap.sh [--dry-run]
This script copies scripts to /usr/local/bin, installs systemd units, and enables timers.
Run as root (sudo).
EOF
      exit 0 ;;
  esac
done

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Use sudo." >&2
  exit 1
fi

echo "Bootstrap starting (dry-run=$DRY_RUN)"

# Ensure source exists
if [ ! -d "$SCRIPTS_SRC" ]; then
  echo "Missing scripts directory: $SCRIPTS_SRC" >&2
  exit 2
fi

# Create dirs
if [ "$DRY_RUN" = false ]; then
  mkdir -p "$SCRIPTS_DST" "$LOG_DIR" "$BACKUP_DIR"
  chown root:root "$SCRIPTS_DST"
  chmod 755 "$SCRIPTS_DST"
fi

# Copy scripts
for f in "$SCRIPTS_SRC"/*.sh; do
  fname=$(basename "$f")
  dst="$SCRIPTS_DST/$fname"
  echo "Installing $fname -> $dst"
  if [ "$DRY_RUN" = false ]; then
    install -m 0755 "$f" "$dst"
  fi
done

# Install systemd unit files from repo root /systemd/ (expects repo to include them in /project/systemd/)
SYSTEMD_SRC_DIR="$REPO_ROOT/project/systemd"
if [ -d "$SYSTEMD_SRC_DIR" ]; then
  for u in "$SYSTEMD_SRC_DIR"/*; do
    uname=$(basename "$u")
    echo "Installing unit $uname -> $SYSTEMD_DST/$uname"
    if [ "$DRY_RUN" = false ]; then
      install -m 0644 "$u" "$SYSTEMD_DST/$uname"
    fi
  done
  if [ "$DRY_RUN" = false ]; then
    systemctl daemon-reload
    systemctl enable --now backup.timer || true
    systemctl enable --now healthcheck.timer || true
  fi
else
  echo "No systemd unit source dir at $SYSTEMD_SRC_DIR (skip systemd installation)"
fi

# Render mermaid diagrams if mmdc available
if command -v mmdc >/dev/null 2>&1; then
  echo "Rendering mermaid diagrams"
  find "$REPO_ROOT/assets" -type f -name '*.mmd' -print0 | while IFS= read -r -d '' f; do
    png="${f%.mmd}.png"
    echo "Rendering $f -> $png"
    if [ "$DRY_RUN" = false ]; then
      mmdc -i "$f" -o "$png"
    fi
  done
else
  echo "mermaid-cli (mmdc) not found. Skipping diagram rendering. To render, install: npm i -g @mermaid-js/mermaid-cli"
fi

# Final messages
if [ "$DRY_RUN" = false ]; then
  echo "Bootstrap complete. Installed scripts to $SCRIPTS_DST and units (if any)."
  echo "Ensure you review /etc/systemd/system/* for correctness before deploying to production."
else
  echo "Dry-run complete. No changes made. Rerun without --dry-run to apply."
fi
