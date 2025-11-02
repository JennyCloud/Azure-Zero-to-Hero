# 🧱 Azure Backup Vault Placement & Geo-Paired Regions

**Author:** Jenny Wang (@JennyCloud)  
**Category:** Azure Backup / Replication Concepts  

---

## 💡 Overview

When configuring **Azure Backup** for virtual machines, one of the most common mistakes is choosing the wrong region for the **Recovery Services vault**.  
Although Azure regions are geo-paired for redundancy, the **vault must always be created in the same region as the protected resource**.

Example:  
If your **VM** is in **Canada Central**, the **Recovery Services vault** must also be in **Canada Central**.  
Azure will handle geo-replication internally if you select **Geo-Redundant Storage (GRS)** for the vault, automatically pairing it with **Canada East** behind the scenes.

---

## 🧠 Key Principles

### 1. Vault and Resource Region Must Match
Azure Backup operates within the same regional fabric to ensure:
- Snapshot consistency during backup operations  
- Low-latency data transfer  
- Full recovery capabilities within the same region  

**✅ Supported:**  
VM (Canada Central) → Vault (Canada Central)

**❌ Not Supported:**  
VM (Canada Central) → Vault (Canada East)

---

### 2. The Role of Geo-Paired Regions

Each Azure region has a **geo-paired region** (for example, Canada Central ↔ Canada East).  
When you select **GRS** as your vault’s storage redundancy option:
- Azure replicates backup data asynchronously to the geo-paired region.  
- You **cannot** directly choose that secondary region for vault creation.  
- This replication ensures regional disaster recovery without manual setup.

So, while you create the vault in **Canada Central**, your backup data is silently copied to **Canada East** as part of the GRS policy.

---

### 3. Why Zone Redundancy Isn’t the Same

Terms like **Zone-Redundant Storage (ZRS)** refer to fault isolation within a region — not across regions.  
Azure Backup doesn’t let you deploy a vault in a “zone-redundant region.”  
Instead, you choose the redundancy level *within* the vault configuration (LRS or GRS).

---

### 🧩 Quick Mnemonic

> “Vaults live **with** their workloads, not **next to** them.”

Keep this line in mind during both real deployments and certification exams — it instantly eliminates the wrong answers.

---

### 🪶 Summary

| Setting | Rule | Example |
|:--|:--|:--|
| Vault placement | Must match resource region | VM (Canada Central) → Vault (Canada Central) |
| Redundancy | Choose LRS or GRS | GRS automatically pairs with Canada East |
| Geo-pair usage | Managed by Azure | No manual selection needed |
| ZRS option | Not available for vaults | Only LRS or GRS supported |

---

> “Vaults are regional citizens — they back up what lives around them, not what lives far away.”

