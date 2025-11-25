# Backup & Restore Gotchas

## Azure VM Backup
- Only supports one backup per day.
- Restore points are daily unless snapshot-based backup is used.

## Blob Backup
- Only one backup per day.
- Backups rely on blob versioning and change feed.

## Azure Files Backup
- Up to 6 snapshots/day.
- Much more flexible compared to Blob backup.

## Deterministic Restores
- Azure Backup prioritizes predictable restore outcomes over high-frequency backups.
- Consistency > frequency.
