#!/usr/bin/env bash
set -euo pipefail

# Defaults (use default if unset OR empty)
OUTDIR="${OUTDIR:-output}"
DAYS="${DAYS:-14}"

# Defensive: never allow empty OUTDIR
if [ -z "${OUTDIR}" ]; then
  OUTDIR="output"
fi

mkdir -p "$OUTDIR"

echo "Collecting evidence into: $OUTDIR (DAYS=$DAYS)"

scripts/collect_system_context.sh "$OUTDIR"
scripts/collect_storage_health.sh "$OUTDIR"

# Run backup signals collector if present
if [ -x scripts/collect_backup_signals.sh ]; then
  scripts/collect_backup_signals.sh "$OUTDIR" "$DAYS"
else
  echo "Note: scripts/collect_backup_signals.sh not found; skipping backup signals collection." \
    > "$OUTDIR/backup_signals_skipped.txt"
fi

echo "Done. Files created:"
ls -la "$OUTDIR"
