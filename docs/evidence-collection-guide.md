# Evidence Collection and Redaction Guide

Before sharing any output externally, redact:
- hostnames, usernames, domains
- IP addresses if requested
- mount paths revealing business/user identifiers
- repository paths (borg/restic/rclone)
- any tokens/keys/passwords (should not exist—verify anyway)

High-value evidence to include:
- schedules (systemd timers / cron)
- timestamps of last successful runs and failures
- retention proof (snapshot/archive lists) with sanitized names
- storage capacity (df output)
- warnings/errors (journal excerpts) with identifiers sanitized
