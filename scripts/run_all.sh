#!/usr/bin/env bash
set -euo pipefail

OUTDIR="${OUTDIR:-output}"
mkdir -p "$OUTDIR"

echo "Collecting evidence into: $OUTDIR"

scripts/collect_system_context.sh "$OUTDIR"
scripts/collect_storage_health.sh "$OUTDIR"

echo "Done. Files created:"
ls -la "$OUTDIR"
