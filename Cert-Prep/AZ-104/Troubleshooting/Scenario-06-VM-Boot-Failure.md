# Troubleshooting Scenario #6 — Azure VM won’t start (provisioning or boot failure)

## Situation
You try to start an Azure VM, but it fails with one of these messages:

- **“Provisioning failed”**  
- **“OSProvisioningTimedOut”**  
- **“VM failed to start”**  
- **“Boot diagnostics captured an error”**  
- **“The disk cannot be mounted”**

Or the VM starts but stays stuck at:

- **Starting**  
- **Updating**  
- **Running (Provisioning… Failed)**  

This is a classic AZ-104 situation because VM startup depends on a chain of components: OS disk → hypervisor → networking → extensions → provisioning agents.

When one link breaks, the VM refuses to boot.

---

## How to think about it

A VM must pass through these checkpoints to start properly:

1. **Disk must attach correctly**  
2. **Hypervisor must read OS bootloader**  
3. **OS must boot and load Azure agent**  
4. **Azure extensions must run**  
5. **VM must report “ready” to Azure fabric**

If any layer fails → VM startup fails.

This is why AZ-104 makes you diagnose root causes logically rather than guessing.

---

## Most common failures

### 1. Broken OS disk (corrupted bootloader or OS files)
If the OS disk has:

- corrupted boot sector  
- missing `ntoskrnl.exe` (Windows)  
- broken GRUB (Linux)  
- damaged filesystem  

…the VM cannot boot.

Boot diagnostics shows:

- Windows “Recovery” blue screen  
- Linux GRUB rescue shell  
- Missing OS loader  

This is the #1 real-world cause.

---

### 2. Extensions stuck or failing
Azure VM extensions can break startup:

- Custom Script Extension failure  
- OmsAgent failure  
- Azure Monitor extension crash  
- Desired State Configuration failure  
- Antivirus extension loop  

Symptoms:

- VM shows “Provisioning failed”  
- Boot diagnostics looks fine (OS runs normally)  

This is extremely common.

---

### 3. OS provisioning agent failure
Azure needs:

- Windows: **Windows Azure Guest Agent**  
- Linux: **waagent**

If the agent is corrupted or missing:

- VM cannot report “ready”  
- Extensions fail  
- Provisioning times out  

Azure sees the VM as “failed to provision,” even though the OS itself booted.

---

### 4. Disk or snapshot restore mismatch
If someone:

- replaces OS disk  
- attaches the wrong disk  
- restores from snapshot incorrectly  

…the VM metadata may not match the OS.

Classic symptom:

> “The disk cannot be mounted”

---

### 5. VM SKU mismatch with OS
If you change the VM size to one that doesn't support:

- Hyper-V Gen 2  
- Nested virtualization  
- Accelerated networking  
- Required features  

…the VM may not start.

E.g., moving a Gen2 VM to an old/basic SKU.

---

## How to solve it — the admin sequence

### Step 1 — Check boot diagnostics
VM → Boot Diagnostics  

Look for:

- Blue screens  
- GRUB errors  
- “No boot device”  
- Stopped at emergency shell  

This tells you if the OS itself is failing.

If diagnostics is blank → VM isn’t even reaching OS boot = disk or host issue.

---

### Step 2 — Check provisioning state
VM → Overview → Status & Provisioning State

If you see:

- “Provisioning Failed”  
- “Updating (Failed)”  
- “VM Agent not responding”  

→ extension or agent issues.

---

### Step 3 — Repair the OS disk
Azure has a built-in rescue workflow:

VM → Disks → **“Create a VM repair disk”** (Repair VM)

This workflow:

- detaches the OS disk  
- mounts it on a temporary repair VM  
- lets you fix:  
  - corrupted files  
  - drivers  
  - bootloader  
  - extensions  

Then you reassemble the VM.

This is AZ-104 gold.

---

### Step 4 — Delete or reinstall extensions
Extensions can block VM provisioning.

Portal → VM → Extensions

Typical fix:

- Delete failing extension  
- Restart VM  
- Reinstall correctly  

Works when the OS boots but agent/ext is stuck.

---

### Step 5 — Switch VM size (SKU)
If the VM uses a size not available in the region or incompatible with features:

- pick a new size  
- start VM again  

This fixes:

- host-related failures  
- unsupported Gen2 hardware  

---

### Step 6 — Check disk attachment
Make sure:

- OS disk is correct  
- LUN 0 is OS disk  
- No orphaned disks  
- Correct generation (Gen1 vs Gen2)  

Wrong disk = no boot.

---

## Why follow these steps?

VM startup is a waterfall:

1. Disk mounts  
2. OS boots  
3. Azure agent runs  
4. Extensions configure  
5. Azure accepts provisioning  

The failure point tells you which layer broke.

If you check out of order:

- You may try fixing extensions when the OS is corrupt  
- You may repair the disk when the problem is only an extension  
- You may check provisioning state when the disk isn’t even attached  
- You may check networking (irrelevant for boot failures)

The sequence follows the *actual boot process* — making troubleshooting logical, predictable, and fast.
