# Backup Verification Toolkit (Linux-first)

A lightweight, evidence-based toolkit for verifying that Linux backups are:
- Running on schedule (systemd timers / cron)
- Not failing silently (warnings/errors + keyword signals)
- Backed by basic storage capacity evidence
- Documented with repeatable restore testing and reporting templates

This repository supports consulting engagements. Do not commit client data or credentials.

## Quick Start
Run evidence collection (default output folder: ./output):

```bash
./scripts/run_all.sh

DAYS=7 ./scripts/run_all.sh


Quick verify:

```bash
sed -n '1,120p' README.md

