#!/usr/bin/env bash
# Purpose: create user accounts and configure groups for the project
# Usage: user-setup.sh username group1,group2 --create-home

set -euo pipefail

if [ "$#" -lt 2 ]; then
  cat <<'EOF'
Usage: user-setup.sh username groups
Example: user-setup.sh alice "admin,analyst"
EOF
  exit 2
fi

USERNAME="$1"
IFS=',' read -r -a GROUPS <<< "$2"

# Create groups if missing
for g in "${GROUPS[@]}"; do
  if ! getent group "$g" >/dev/null; then
    sudo groupadd -- "$g"
    echo "Created group $g"
  fi
done

if ! id -u "$USERNAME" >/dev/null 2>&1; then
  sudo useradd -m -s /bin/bash "$USERNAME"
  echo "Created user $USERNAME"
else
  echo "User $USERNAME already exists"
fi

# Add user to groups
for g in "${GROUPS[@]}"; do
  sudo usermod -aG "$g" "$USERNAME"
  echo "Added $USERNAME to $g"
done

# Lock password (encourage SSH keys)
sudo passwd -l "$USERNAME" || true

echo "User setup complete for $USERNAME"
