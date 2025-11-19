# Lab 02 - Implement Backup and Recovery

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Monitor and maintain Azure resources (10–15%)**

Implement Backup and Recovery
- Create a Recovery Services vault
- Create an Azure Backup vault
- Create and configure a backup policy
- Perform backup and restore operations by using Azure Backup
- Configure Azure Site Recovery for Azure resources
- Perform a failover to a secondary region by using Site Recovery
- Configure and interpret reports and alerts for backups


## What Azure Administrators Do in Real Work

### 1. They never trust that “backup is running” — they verify it every morning.
Admins open Backup Jobs at the start of the day like checking the weather:

- Did the VM snapshot fail?
- Did the vault choke on storage limits?
- Did the backup agent timeout?
- Did a policy quietly stop applying?

Because if something is broken for **3 days**, you no longer have a valid restore point.  
That’s how people lose data.

Backup is only “safe” if someone is regularly checking it.

### 2. They tune retention policies based on cost and compliance.
Retention affects **vault cost** and **legal requirements**.

Examples:
- Developers want 7-day retention → cheap  
- Finance wants 1-year retention → expensive  
- Healthcare wants 7-year retention → very expensive  

Admins juggle:
- Cost  
- Performance  
- Legal requirements  
- Storage account limits  

It’s a dance between “don’t spend too much” and “don’t get fired when someone deletes data.”

### 3. They watch for backup alerts like a nervous parent.
When something goes wrong:

- **VM Agent not ready**  
- **Snapshot extension failed**  
- **VSS failure on Windows**  
- **Kernel unsupported on Linux**  
- **Storage account throttling**  
- **Region-wide snapshot issues**

Admins get an email or Teams alert.  
Their job: fix it before the next backup window.

### 4. They run test restores regularly.
Backups are meaningless unless you prove you can restore.

Admins schedule:
- Quarterly test restores  
- Random spot checks  
- Cross-region restore tests  

Companies with audits must demonstrate:

**“We can restore this VM, this file share, this database within X hours.”**

Admins keep screenshots as evidence.

### 5. They optimize what gets backed up — not everything needs protection.
Examples:

- Temporary dev VMs? → No backup.  
- Domain controllers? → Yes.  
- App servers with disk caching? → Yes.  
- Stateless servers? → Usually no.

Admins classify workloads like museum curators deciding what deserves protection.

### 6. They clean up stale backups and vaults.
Old vaults get expensive.

Admins:
- Delete orphaned backups  
- Retire old VMs  
- Remove unused vaults  
- Stop protection when servers are decommissioned  

Otherwise costs keep rising every month.

### 7. They manage multiple vaults across regions, departments, projects.
Big companies have:

- 10–50 vaults  
- Across multiple regions  
- With different policies  
- Different legal retention requirements  

Admins track all of them like a constellation of moving parts.

### 8. They handle restores after “someone accidentally deleted the thing.”
A very real sequence:

1. Developer deletes a production folder.  
2. Manager screams.  
3. Admin restores from backup.  
4. Developer claims innocence.  
5. Admin logs the restore in their incident tracker.  
6. Everyone pretends it won’t happen again.  

Admins deal with this weekly.

### 9. They prepare for regional disasters even if they never happen.
Site Recovery is part of business continuity:

- If Region A fails  
- ASR brings up Region B  
- DNS switches  
- Apps keep running  

Admins set this up, test once a year, and hope they never need to use it.

### 10. They educate teams on what backup can and can’t do.
End users have magical expectations:

“Can you restore the VM exactly as it was 94 days ago at 2:24 PM?”

Admins explain:
- Retention limits  
- Restore granularity  
- Application-consistent vs crash-consistent  
- Snapshot limitations  
- That VMs must actually be running for backup  

Admins become teachers more than technicians.


