# Sample Backup Verification Report (Sanitized)

## Executive Summary
Status: Partial  
- Backups run nightly but failures were present in the last 14 days.
- Retention is unclear (pruning not verified).
- File-level restore test succeeded.

## Evidence Summary
- Last successful job: 2026-01-10 02:15 UTC
- Failures in last 30 days: 2
- Retention verified: Not confirmed
- Restore test performed: Yes (file-level)

## Recommendations
1. Add alerting on failures (email or webhook).
2. Define retention and verify prune jobs are running.
3. Perform quarterly restore tests and document results.
