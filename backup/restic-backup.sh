#!/usr/bin/env bash
# Restic backup to BigNAS
set -euo pipefail

export RESTIC_REPOSITORY="/mnt/BigNAS/backups/restic"
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"

# Initialize repo if it doesn't exist
if ! restic snapshots &>/dev/null; then
    echo "Initializing restic repository..."
    restic init
fi

# Run backup
restic backup "$HOME" \
    --exclude-file="$HOME/dotfiles/backup/restic-exclude.txt" \
    --exclude-caches \
    --verbose

# Prune old snapshots: keep 7 daily, 4 weekly, 6 monthly
restic forget \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 6 \
    --prune

echo "Backup complete: $(date)"
