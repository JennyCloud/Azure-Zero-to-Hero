# Restore vs Replication in Azure Storage

## Replication
Replication copies blob data from one storage account to another as changes occur.  
It is forward-moving and continuous.

### Key Characteristics
- Sends blob changes as they happen.
- Requires **blob versioning on both source and destination**.
- Requires **change feed on the source**.
- Used for disaster recovery, geo redundancy, read offloading, and compliance.
- Destination becomes a near-real-time mirror.
- Does not allow rolling the source back in time.

Replication behaves like sending every change to a second account—continual copying.

---

## Restore
Restore rewinds blob data **within the same storage account** to a previous point in time.

### Key Characteristics
- Operates only inside one account.
- Requires **Point-in-Time Restore (PITR)** enabled.
- Allows recovery after accidental deletes, bad updates, or ransomware.
- No second account is involved.

Restore behaves like a time-travel undo button for containers.

---

## Quick Memory Rule
**Replication mirrors; restore rewinds.**

- Replication: copy outward to another account.
- Restore: go backward inside the same account.
