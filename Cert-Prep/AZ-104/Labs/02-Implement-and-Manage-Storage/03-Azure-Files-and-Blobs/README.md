# Lab 3 – Configure Azure Files and Azure Blob Storage  

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Implement and manage storage (15–20%)**

Configure Azure Files and Azure Blob Storage
- Create and configure a file share in Azure Storage
- Create and configure a container in Blob Storage
- Configure storage tiers
- Configure soft delete for blobs and containers
- Configure snapshots and soft delete for Azure Files
- Configure blob lifecycle management
- Configure blob versioning

## What Azure Administrators Do in Real Work

Azure storage isn’t just a lab exercise — it’s a constant balancing act between **performance, protection, and cost**.  
Here are the real-world tasks admins repeatedly perform.

### 1. Manage File Shares for Legacy Apps
Many organizations still rely on SMB file shares for:
- Lift-and-shift file servers  
- FSLogix user profiles  
- On-premises apps moved into Azure  

Admins regularly:
- Create shares  
- Assign NTFS permissions  
- Enable soft delete  
- Use snapshots to recover overwritten or missing files

Snapshots and soft delete act as the first line of defense before restoring from cold backups.

### 2. Control Blob Data Explosion
Blobs grow fast — logs, exports, reports, backups, telemetry, and temp files pile up by the terabyte.

Admins rely on:
- **Blob versioning** to protect against accidental overwrites  
- **Soft delete** to recover deleted data  
- **Container soft delete** for whole-container recovery  

These protect against application bugs, ransomware, and human mistakes.

### 3. Optimize Storage Costs with Tiers
Different workloads need different tiers:

- **Hot:** interactive apps  
- **Cool:** monthly reports, analytics dumps  
- **Archive:** rarely touched compliance data  

Admins constantly review storage analytics to move blobs between tiers or depend on automated lifecycle rules.

### 4. Automate Deletions and Tiering with Lifecycle Management
Enterprise storage rules typically:
- Move blobs to Cool after 30 days  
- Move to Archive after 90–180 days  
- Delete after 1–3 years  

This eliminates manual cleanup and keeps storage costs predictable.

### 5. Generate SAS Tokens for Temporary Access
Developers, vendors, and analysts often need short-term access to blobs or containers.

Admins generate SAS with:
- Scoped permissions  
- Limited expiry  
- HTTPS enforced  
- No account key exposure  

SAS rotation is a core operational practice.

### 6. Monitor Storage Health and Protect Critical Data
Admins monitor:
- Redundancy (GRS/LRS/ZRS)  
- Access logs  
- Change feed  
- Versioning behavior  
- Rehydration times for Archive blobs  
- Share capacity limits  

This ensures apps stay stable and compliant.

### 7. Understand What Each Storage Account Is For
Real environments typically separate workloads:

- One storage account for Azure Files  
- One for Blobs + versioning + lifecycle  
- One for backups  
- One for diagnostics logs  

This avoids mixing incompatible settings and keeps billing cleaner.
