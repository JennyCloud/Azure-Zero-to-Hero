# Azure VM Backup – Agentless VM Backup vs MARS Agent Backup

When backing up Azure virtual machines, there are two fundamentally different backup models to understand:

- **Agentless VM Backup (image-level)**
- **MARS Agent Backup (file-level)**

They complement each other but are designed for different scenarios.

---

## 1. Agentless VM Backup (Image-Level)

**What it is**

Agentless VM backup is the standard Azure VM backup that works **without installing any backup agent** inside the VM. Azure Backup takes a **snapshot of the entire VM** at the disk level:

- OS disk
- Data disks
- VM configuration

This is an **image-level backup**.

**How it works**

- Uses storage-level snapshots of the managed disks
- Can be application-consistent (via VSS on Windows) or crash-consistent
- Treats the VM as a set of disks + metadata, not as a collection of files

**What you can restore**

- ✔ Restore the **entire VM** in place (overwrite the original)
- ✔ Restore the VM as a **new VM**
- ✔ Restore **individual disks** and attach them to another VM

**What you CANNOT do**

- ✖ No direct **file-level restore** to arbitrary machines
- ✖ You can’t browse the backup as a file tree and pick individual files to restore

Because the backup is done at the disk level, Azure Backup only “sees” disk blocks, not individual files.

---

## 2. MARS Agent Backup (File-Level)

**What it is**

The **MARS (Microsoft Azure Recovery Services) agent** runs *inside* the VM’s guest OS. It understands the file system and can perform **file-level backup**.

**How it works**

- Installed on the VM (Windows)
- Has access to:
  - File system and directories
  - File metadata and permissions
  - Incremental file changes
- Sends selected files/folders to the Recovery Services vault

**What you can restore**

- ✔ Restore **individual files and folders**
- ✔ Restore to **arbitrary machines** (not just the original VM)
- ✔ Use it for granular recovery after events like ransomware or accidental deletion

**What you CANNOT do**

- ✖ It is **not intended for full VM image restore**
- ✖ Doesn’t provide the same “rebuild entire VM” experience as agentless VM backup

---

## 3. Quick Comparison

| Feature                              | Agentless VM Backup (Image-Level)       | MARS Agent Backup (File-Level)           |
|--------------------------------------|-----------------------------------------|------------------------------------------|
| Requires agent in VM                 | No                                      | Yes                                      |
| Backup granularity                   | Entire VM (disks + config)              | Files and folders                        |
| Restore entire VM                    | ✔ Yes                                   | ✖ No                                     |
| Restore individual disks             | ✔ Yes                                   | ✖ No                                     |
| Restore individual files             | ✖ No                                    | ✔ Yes                                    |
| Restore to arbitrary machines        | Limited (via disk attach)               | ✔ Yes (file-level)                       |
| Best use case                        | Full VM recovery / DR                   | File-level recovery / granular restore   |

---

## 4. Mental Model

- **Agentless VM Backup** = A full **image** of your machine. Great for putting the *whole* VM back exactly as it was.
- **MARS Agent Backup** = A **librarian** inside the OS who tracks individual files and lets you restore specific items wherever you need.

Each has a different job. For ransomware or full-VM disasters, image-level backup is ideal. For fine-grained recovery of a few critical files, MARS agent backup is the better tool.
