# Backup Verification Checklist (Linux-first)

## 1) Inventory and scope
- Systems in scope (VMs, bare metal, NAS, SaaS where applicable)
- Backup method/tool (rsync, borg, restic, rclone, snapshots, vendor appliance)
- Backup destinations (local disk, NAS, offsite, cloud, immutable/WORM)
- RPO/RTO (even if approximate)

## 2) Job execution evidence (last 14–30 days)
- Confirm schedules (systemd timers, cron, orchestrator)
- Confirm successful runs and failures
- Capture evidence (logs, job output, timestamps)

## 3) Retention sanity check
- Count restore points / archives
- Validate pruning/retention rules exist and are running
- Capture evidence (archive list, snapshot list)

## 4) Storage and destination health
- Destination free space and growth trend (quick check)
- Filesystem errors indicators (where available)
- Capture evidence (df output, SMART status if applicable)

## 5) Restore test (non-destructive)
- File-level restore test to an alternate path
- Verify file integrity (hash compare if feasible)
- Capture evidence (commands + output)

## 6) Report and recommendations
- Findings summary
- Top risks (silent failures, no offsite, no retention, no restore test)
- Prioritized remediation plan
