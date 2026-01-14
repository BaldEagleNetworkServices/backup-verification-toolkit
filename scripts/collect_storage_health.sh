#!/usr/bin/env bash
set -euo pipefail

OUTDIR="${1:-output}"
mkdir -p "$OUTDIR"

df -hT > "$OUTDIR/df.txt" || true

{
  echo "=== mount ==="
  mount 2>/dev/null || true
  echo
  echo "=== /etc/fstab (review/redact before sharing) ==="
  cat /etc/fstab 2>/dev/null || true
} > "$OUTDIR/storage_mounts.txt"

if command -v smartctl >/dev/null 2>&1; then
  {
    echo "SMART available. Run per-disk manually if needed:"
    echo "  sudo smartctl -H /dev/sdX"
  } > "$OUTDIR/smart_note.txt"
else
  echo "smartctl not installed; skipping SMART guidance." > "$OUTDIR/smart_note.txt"
fi
