#!/usr/bin/env bash
set -euo pipefail

OUTDIR="${OUTDIR:-output}"
mkdir -p "$OUTDIR"

echo "Collecting evidence into: $OUTDIR"

# System context
{
  echo "timestamp: $(date -Is)"
  echo "host: $(hostname -f 2>/dev/null || hostname)"
  echo "kernel: $(uname -r)"
  echo
  echo "=== /etc/os-release ==="
  cat /etc/os-release 2>/dev/null || true
} > "$OUTDIR/system_context.txt"

# Storage
df -hT > "$OUTDIR/df.txt" || true

echo "Done."
ls -la "$OUTDIR"
