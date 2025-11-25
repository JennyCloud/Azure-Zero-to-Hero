# Azure Storage: Hidden Rules & Gotchas

## Storage Account Tiers
- Hot tier may cost more than Cool tier if your workload is infrequently accessed.
- Archive tier cannot be mounted or browsed; must rehydrate.

## Azure Files
- Azure Container Instances use **Azure Files only** for persistent storage.
- Premium File Shares require FileStorage account kind.

## Blob Storage
- Immutable Blob policies have strict limits.
- Object Replication requires:
  - Versioning on source & destination
  - Change feed enabled
- Blob backups only allow **one backup per day**.

## Azure SQL Backup Limitation
- Azure SQL Database backups **cannot** be redirected to user-created storage accounts.
- All backups stored internally and managed by Microsoft.

## Shared Access Signatures (SAS)
- Stored Access Policies do not apply to account-level SAS.
- Ad hoc SAS = direct, inline SAS without a stored policy.

## Encryption Scopes
- Only apply to **blob containers and blobs**, not file shares, queues, or tables.
