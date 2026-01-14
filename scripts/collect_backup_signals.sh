#!/usr/bin/env bash
set -euo pipefail

OUTDIR="${1:-output}"
DAYS="${2:-14}"
mkdir -p "$OUTDIR"

# 1) Scheduling evidence
{
  echo "=== systemd timers ==="
  systemctl list-timers --all 2>/dev/null || echo "systemctl not available"
  echo
  echo "=== cron locations ==="
  ls -la /etc/cron* 2>/dev/null || echo "cron directories not accessible"
  echo
  echo "=== current user crontab ==="
  crontab -l 2>/dev/null || echo "no user crontab"
} > "$OUTDIR/scheduling_signals.txt"

# 2) Tool presence (vendor-neutral)
{
  echo "=== borg ==="
  if command -v borg >/dev/null 2>&1; then
    borg --version
    echo "Note: repo listing requires BORG_REPO and usually a passphrase; not executed by default."
  else
    echo "borg not installed"
  fi
  echo
  echo "=== restic ==="
  if command -v restic >/dev/null 2>&1; then
    restic version
    echo "Note: snapshots require RESTIC_REPOSITORY and password; not executed by default."
  else
    echo "restic not installed"
  fi
  echo
  echo "=== rsync ==="
  if command -v rsync >/dev/null 2>&1; then
    rsync --version | head -n 2
  else
    echo "rsync not installed"
  fi
  echo
  echo "=== rclone ==="
  if command -v rclone >/dev/null 2>&1; then
    rclone version | head -n 3
  else
    echo "rclone not installed"
  fi
  echo
  echo "=== duplicity ==="
  if command -v duplicity >/dev/null 2>&1; then
    duplicity --version
  else
    echo "duplicity not installed"
  fi
} > "$OUTDIR/tool_presence.txt"

# 3) Journal evidence (backup keywords, warnings)
if command -v journalctl >/dev/null 2>&1; then
  journalctl --since "${DAYS} days ago" -p warning..alert \
    > "$OUTDIR/journal_warnings_last_${DAYS}_days.txt" || true

  journalctl --since "${DAYS} days ago" \
    | egrep -i "backup|borg|restic|rsync|snapshot|btrfs|zfs|rclone|duplicity|veeam|urbackup" \
    > "$OUTDIR/journal_backup_keywords_last_${DAYS}_days.txt" || true
else
  echo "journalctl not found; skipping journal evidence." > "$OUTDIR/journal_not_available.txt"
fi

# 4) Candidate log file paths (safe listing only)
{
  echo "=== /var/log candidate files (backup keywords) ==="
  find /var/log -maxdepth 2 -type f 2>/dev/null \
    | egrep -i "backup|borg|restic|rsync|rclone|duplicity|snapshot|urbackup|veeam" || true
} > "$OUTDIR/log_candidates.txt"
