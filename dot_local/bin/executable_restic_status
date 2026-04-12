#!/usr/bin/env bash
# This script is intended to be run by systemd timer

# Exit on failure or pipefail
set -e -o pipefail

# Set this to any location you like
BACKUP_PATHS="/home/dabrown"

BACKUP_TAG=systemd.timer

# How many backups to keep
RETENTION_HOURLY=25
RETENTION_DAYS=9
RETENTION_WEEKS=6
RETENTION_MONTHS=18
RETENTION_YEARS=5

source /home/dabrown/.ssh/restic_env

# Remove locks in case other stale processes kept them in
restic unlock &
wait $!

# Remove old backups
restic forget \
  --verbose \
  --tag ${BACKUP_TAG} \
  --dry-run \
  --keep-hourly ${RETENTION_HOURLY} \
  --keep-daily ${RETENTION_DAYS} \
  --keep-weekly ${RETENTION_WEEKS} \
  --keep-monthly ${RETENTION_MONTHS} \
  --keep-yearly ${RETENTION_YEARS} &
wait $!

# Check if everything is fine
restic check &
wait $1

echo "Backup done"
echo "$VAR"
