# Encryption at Host vs Azure Disk Encryption (ADE)

## Overview
Encryption at host is an Azure feature that encrypts data **at the hypervisor level**, ensuring that all data written to VM disks is encrypted *before* it ever leaves the compute host.  
This is different from Azure Disk Encryption (ADE), which performs encryption **inside the VM** using BitLocker (Windows) or dm-crypt (Linux).

Think of the three Azure encryption layers like nested shells:
- **Server-Side Encryption (SSE)** — storage-level encryption  
- **Encryption at Host** — hypervisor-level encryption  
- **Azure Disk Encryption (ADE)** — in-guest OS-level encryption  

These layers stack but serve different purposes.

---

## What Encryption at Host Does
Encryption happens *below* the operating system, at the virtualization host. Azure performs:
- Encryption of **OS disks**
- Encryption of **data disks**
- Encryption of **temporary disks**
- Encryption of **VM cache**

This is something ADE cannot do (ADE never encrypts temporary disks or host cache).

### Key Characteristics
- No VM agent required  
- No OS modification  
- No bootloader changes  
- No BitLocker or dm-crypt complexity  
- No Key Vault required (unless using CMK)  
- Works with both Linux and Windows  
- Minimal operational overhead  

---

## Why Encryption at Host Exists
Azure Disk Encryption (ADE) is powerful but comes with strict requirements:
- Limited OS support  
- Requires extensions inside the VM  
- Requires Key Vault setup  
- Modifies bootloaders  
- Fails often with custom images or Gen2 OS disks  

Encryption at Host was created to offer:
- **A simpler, more reliable encryption model**
- **Protection of data between compute host → storage**
- **Fewer operational headaches**
- **Broader compatibility**

Most modern deployments prefer:
**Encryption at Host + SSE (with CMK if needed)**  
ADE is now used mainly when compliance explicitly requires in-guest encryption.

---

## What Encryption at Host Does *Not* Do
- Does not replace BitLocker or dm-crypt  
- Does not provide in-guest key management  
- Does not satisfy compliance frameworks that require OS-level encryption  
- Does not allow per-disk BitLocker recovery keys  

If your policy or regulator demands **in-guest encryption**, ADE is still required.

---

## How It's Enabled
### For New VMs
You enable “Encryption at host” during VM creation under the **Disk** settings.

### For Existing VMs
- Stop/deallocate the VM  
- Enable encryption at host  
- Start the VM again  

This property sits in the VM’s compute profile.

---

## Quick Comparison Table

| Feature / Capability               | Encryption at Host | Azure Disk Encryption (ADE) |
|-----------------------------------|--------------------|-----------------------------|
| Encryption Layer                  | Hypervisor-level   | In-guest (BitLocker/LUKS)   |
| Temporary Disk Encrypted          | Yes                | No                          |
| Host Cache Encrypted              | Yes                | No                          |
| Requires VM Agent                 | No                 | Yes                         |
| Requires Key Vault                | No (unless CMK)    | Yes (KEK/BEK)               |
| OS Modifications                  | No                 | Yes                         |
| OS Disk Compatibility Requirements| Minimal            | Strict                      |
| Works with Gen2 VMs               | Yes                | Not always                  |
| Operational Complexity            | Low                | Medium/High                 |

---

## Mental Model
- **ADE** encrypts *inside* the VM.  
- **Encryption at Host** encrypts *around* the VM.  
- **SSE** encrypts *beneath* the VM.

Together, they form layered protection with different guarantees.

