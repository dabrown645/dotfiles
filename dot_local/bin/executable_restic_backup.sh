#!/usr/bin/env bash
# This script is intended to be run by systemd timer

set -euo pipefail

LOGFILE="/tmp/restic_backup.log"
exec >"${LOGFILE}" 2>&1

echo "=== Starting backup at $(date) ==="
echo "Running as user: $(whoami)"
echo "HOME = ${HOME}"
echo "PATH = ${PATH}"

BACKUP_PATHS="/home/dabrown"
BACKUP_TAG=systemd.timer

RETENTION_HOURLY=25
RETENTION_DAYS=9
RETENTION_WEEKS=6
RETENTION_MONTHS=18
RETENTION_YEARS=5

cd "${HOME}"
source "${HOME}/.ssh/restic_env"

echo "--- Running restic unlock ---"
restic unlock

echo "--- Running restic backup ---"
restic backup \
  --verbose \
  --exclude .cache \
  --exclude Downloads \
  --exclude Code \
  --exclude VMS \
  --one-file-system \
  --tag "${BACKUP_TAG}" \
  ${BACKUP_PATHS}

echo "--- Running restic forget/prune ---"
restic forget \
  --verbose \
  --tag "${BACKUP_TAG}" \
  --prune \
  --keep-hourly "${RETENTION_HOURLY}" \
  --keep-daily "${RETENTION_DAYS}" \
  --keep-weekly "${RETENTION_WEEKS}" \
  --keep-monthly "${RETENTION_MONTHS}" \
  --keep-yearly "${RETENTION_YEARS}"

echo "--- Running restic check ---"
restic check

echo "--- Running rsync ---"

/usr/bin/rsync -a \
  -e "ssh -i /home/dabrown/.ssh/id_ed25519_backup -o BatchMode=yes -o StrictHostKeyChecking=accept-new" \
  --delete \
  /Storage/Backups/restic/backups/ \
  dabrown@10.0.0.57:/Storage/Backups/restic/backups/
# --verbose \

if [[ $? -ne 0 ]]; then
  echo "!!! rsync failed — see /tmp/rsync_debug.log"
  exit 1
fi

echo "--- Running restic check on remote ---"
restic -r sftp:dabrown@10.0.0.57:/Storage/Backups/restic/backups check

echo "rsync done"
echo "=== Backup complete at $(date) ==="
