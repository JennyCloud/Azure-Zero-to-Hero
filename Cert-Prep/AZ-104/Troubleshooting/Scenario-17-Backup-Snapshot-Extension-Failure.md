# Troubleshooting Scenario #17 — Azure Backup: VM Backup Fails with “Snapshot Failure” or “Extension Failure”

## Situation
A VM that has been backing up successfully suddenly begins failing backup jobs.  
In the Recovery Services Vault, you see errors like:

- **UserErrorGuestAgentStatusUnavailable**  
- **ExtensionSnapshotFailed**  
- **UserErrorRpCreationFailed**  
- **VMExtensionProvisioningError**  
- **Snapshot task failed**  
- **Failed to contact Volume Shadow Copy Service (VSS)**  
- **Pre-snapshot script failed** (Linux)

Backups stop running, no new restore points are generated, and protection status may show **Warning** or **Critical**.

This is a high-value AZ-104 troubleshooting scenario because Azure Backup depends on multiple layers: VM agent → backup extension → OS snapshot service → managed disks → network → vault.

---

## How to think about it

Azure VM Backup workflow:

1. The **Azure Backup extension** runs inside the VM.  
2. Extension asks the **VM Agent** to take a snapshot.  
3. The OS prepares for snapshot:  
   - Windows uses **VSS**  
   - Linux uses **fsfreeze**  
4. Azure creates a **managed disk snapshot**.  
5. Snapshot is transferred to the Recovery Services Vault.  
6. Recovery point is created.

If any layer breaks → the backup job fails.

---

## Most common causes

### 1. VM Agent missing or corrupted
Most frequent cause.  
Backup cannot run when:

- VM Agent is outdated  
- VM Agent is corrupted  
- VM Agent was removed  
- VM Agent cannot communicate with Azure fabric  

---

### 2. Backup extension failure
Errors like:

- "Extension failed to install"  
- "Backup extension timed out"  
- "Extension handler crashed"

Often caused by:

- OS script execution restrictions  
- Corrupt extension directory  
- Antivirus blocking processes

---

### 3. VSS failure (Windows)
Windows VSS issues commonly cause:

- Failed snapshot  
- “VSS writers are in failed state”  
- Low disk space  
- Backup-related services disabled

---

### 4. Linux fsfreeze or pre-snapshot failures
Linux snapshots fail when:

- Filesystem cannot freeze  
- `fsfreeze` not installed  
- LVM configuration prevents freeze  
- Databases not configured correctly

---

### 5. Snapshot creation blocked
Snapshot may fail if:

- VM disk is not a managed disk  
- Ultra disk snapshot unsupported  
- Resource providers not registered  
- Resource group lock applied  
- VM in invalid state

---

### 6. Networking or private endpoint issues
Backup service requires outbound access.

Failures caused by:

- NSG blocking outbound 443  
- Firewall restrictions  
- Incorrect service tags  
- Misconfigured private endpoints  
- UDR sending traffic to wrong next hop

---

### 7. Disk encryption issues
If using:

- Azure Disk Encryption  
- Customer-managed keys  
- KEK/BEK mismatch  
- Key Vault firewall restrictions  

Snapshot creation may fail.

---

## How to solve it — admin sequence

### Step 1 — Check VM Agent health
Inside VM:

**Windows:**
Get-Service RdAgent
Get-Service WindowsAzureGuestAgent

**Linux:**
ps -ef | grep waagent


- Restart if stopped  
- Reinstall if missing or corrupted  

---

### Step 2 — Reinstall Backup extension
Portal → VM → **Extensions + applications**

Remove:

- `IaaSBackupAgent`  
- `VMSnapshot`  
- Any failed backup extension  

Azure Backup will reinstall it automatically during next backup.

---

### Step 3 — Verify VSS (Windows)
Check VSS writers:

vssadmin list writers


Fix:

- Restart VSS  
- Restart COM+ and RPC services  
- Free disk space  
- Reboot VM if needed

---

### Step 4 — Verify fsfreeze (Linux)
Test:

sudo fsfreeze -f /
sudo fsfreeze -u /


Fix:

- Update kernel  
- Fix unsupported filesystem  
- Resolve LVM or mount configuration issues  

---

### Step 5 — Validate snapshot prerequisites
Ensure:

- Managed disks in use  
- No resource group locks  
- Storage and Compute providers registered  
- Disk SKU supports snapshots

---

### Step 6 — Check networking
Ensure the VM can reach Azure Backup services:

- Outbound 443 allowed  
- `AzureBackup` and `AzureStorage` service tags allowed  
- No UDR blackholes  
- Private endpoints resolving correctly  

---

### Step 7 — Validate encryption settings
If encrypted:

- Ensure Key Vault allows VM to access keys  
- Ensure KEK/BEK not deleted  
- Check Key Vault firewall rules  

---

### Step 8 — Retry backup
From Recovery Services Vault:

- Trigger **Backup Now**  
- Monitor job details  

---

## Why follow these steps?

Backup failures follow Azure’s internal backup pipeline:

1. **VM Agent** must run  
2. **Backup extension** must install and execute  
3. **OS snapshot system** must work (VSS/fsfreeze)  
4. **Snapshot creation** must succeed  
5. **Network** must reach backup endpoints  
6. **Vault** must finalize the recovery point  

Troubleshooting out of order causes confusion:

- Fixing OS snapshot doesn’t help if VM Agent is broken  
- Fixing VM Agent doesn’t help if outbound traffic is blocked  
- Fixing network doesn’t help if extension is corrupted  
- Fixing extension doesn’t help if Key Vault denies access  

Following the actual backup pipeline solves the issue correctly.
