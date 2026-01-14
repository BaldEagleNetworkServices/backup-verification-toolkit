#!/usr/bin/env bash
set -euo pipefail

OUTDIR="${1:-output}"
mkdir -p "$OUTDIR"

ts="$(date -Is)"
host="$(hostname -f 2>/dev/null || hostname)"

{
  echo "timestamp: $ts"
  echo "host: $host"
  echo "kernel: $(uname -r)"
  echo
  echo "=== /etc/os-release ==="
  cat /etc/os-release 2>/dev/null || true
  echo
  echo "=== uptime ==="
  uptime 2>/dev/null || true
} > "$OUTDIR/system_context.txt"

{
  echo "=== lscpu ==="
  lscpu 2>/dev/null || true
  echo
  echo "=== lsblk ==="
  lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL 2>/dev/null || true
} > "$OUTDIR/hardware_overview.txt"
