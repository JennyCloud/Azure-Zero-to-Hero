# Troubleshooting Scenario #18 — Azure VM: OS Disk is Full, VM Becomes Unresponsive, and Services Fail

## Situation
A Windows or Linux Azure VM becomes slow, unstable, or unreachable.  
Inside the VM (or via diagnostics), you discover:

- **OS disk (C: or /) is 100% full**  
- Updates cannot install  
- Applications crash  
- Extensions fail to install  
- Azure Backup and VM Agent stop working  
- RDP/SSH becomes unreliable  
- VM shows “Provisioning Failed”  
- Guest Agent Status: **Not Ready**

This is a common AZ-104 scenario because many VMs use small OS disks (30–64GB), and logs or apps quickly fill them up.

---

## How to think about it

A full OS disk breaks the VM in escalating layers:

### Layer 1 — OS begins to fail
Windows:
- No space for paging file  
- Cannot write event logs  
- Services crash  

Linux:
- `/var/log` fills  
- daemons fail  
- package manager breaks  

### Layer 2 — VM Agent fails  
The Azure VM Agent cannot run extensions or process backups.

### Layer 3 — RDP/SSH becomes unstable  
Logins require writing temp/session files.

### Layer 4 — VM becomes unreachable  
You may lose the ability to log in normally.

---

## Most common causes

### 1. Guest OS logs filling the disk
Windows:
- Windows Update logs  
- CBS logs  
- Temp folder sprawl  
- Event logs  
- Crash dumps  

Linux:
- `/var/log` growth  
- Docker logs  
- `journalctl` logs  

---

### 2. Application logs unbounded
Apps writing constantly to:

- `C:\Logs\`  
- `/var/log/app`  

No rotation → disk fills up.

---

### 3. Windows Installer folder >10GB
Common when installing .NET/Windows updates repeatedly.

---

### 4. Docker images layering on the OS disk
Even if containers run from a data disk, metadata grows on OS disk.

---

### 5. Antivirus quarantine filling disk
Defender or 3rd-party AV stores large files secretly.

---

### 6. Update cache sprawl
Windows `SoftwareDistribution` folder can exceed 10GB.

---

### 7. OS disk is too small
Default 30–64GB often insufficient.

---

## How to solve it — admin sequence

### Step 1 — Try to access the VM  
Use:

- RDP / SSH  
- Azure Bastion  
- **Serial Console** (best when disk is full)

If regular login fails, Serial Console is most reliable.

---

### Step 2 — Immediately free up space  
**Windows:**
cleanmgr /verylowdisk
del C:\Windows\Temp* /s /q
del C:\Temp* /s /q
net stop wuauserv
del C:\Windows\SoftwareDistribution\Download* /s /q

**Linux:**
sudo journalctl --vacuum-size=100M
sudo rm -rf /var/log/.gz
sudo rm -rf /var/log/journal/
sudo apt clean
sudo yum clean all


Goal: free **5–10 GB** so OS and VM Agent can breathe.

---

### Step 3 — Extend the OS disk (Permanent fix)
Azure Portal → VM → **Disks** → OS Disk → **Size + Performance**

Increase disk:

- 64GB → 128GB  
- 128GB → 256GB  

Then expand partition:

**Windows:**  
Disk Management → Extend Volume  

**Linux:**
sudo growpart /dev/sda 2
sudo resize2fs /dev/sda2

---

### Step 4 — Restart or reinstall VM Agent  

**Windows:**
Restart-Service WindowsAzureGuestAgent

**Linux:**
sudo systemctl restart waagent


If VM Agent was corrupted, reinstall it.

---

### Step 5 — Configure log rotation  
Windows:
- Limit event log sizes  
- Configure cleanup of temp/update caches  
- Move app logs to data disk  

Linux:
- Review `/etc/logrotate.d`  
- Limit journald logs  
- Configure Docker log rotation  

---

### Step 6 — Move heavy workloads off OS disk
Examples:

- App logs → Data disk  
- Docker storage → Data disk  
- Database files → Data disk  
- Temp/cache directories → Data disk  

---

### Step 7 — Restart VM if necessary
After freeing space and stabilizing the system, reboot may repair stuck services.

---

## Why follow these steps?

A VM fails in layers as space runs out:

1. **Disk full → OS cannot write**  
2. **OS cannot write → VM Agent fails**  
3. **VM Agent fails → No backups, no extensions**  
4. **OS services fail → RDP/SSH stops**  
5. **Authentication fails → VM unreachable**

Troubleshooting out of order causes delays:

- Extending disk doesn’t help if VM Agent can’t start  
- Reinstalling VM Agent won’t work if disk is still full  
- Restarting VM won’t help until space is freed  
- Clearing logs doesn’t solve long-term if disk is too small  

Correct order = **free space → expand disk → repair agent → fix root cause (logs/apps).**
