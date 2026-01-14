# Restore Test Procedure (Non-Destructive)

## Goal
Prove that a restore can be performed and validate basic integrity without overwriting production data.

## Steps
1. Select a representative dataset:
   - A small directory with documents and (if applicable) a database dump
2. Restore to an alternate location:
   - Example: /tmp/restore-test-YYYYMMDD/
3. Validate:
   - File opens (manual spot check)
   - Hash compare (optional but recommended for a small sample):
     - sha256sum source and restored files
4. Record evidence:
   - Commands used
   - Output snippets
   - Timestamp
5. Document any gaps:
   - Missing encryption keys
   - Incomplete archives
   - Permission issues
   - Tool/version mismatch
