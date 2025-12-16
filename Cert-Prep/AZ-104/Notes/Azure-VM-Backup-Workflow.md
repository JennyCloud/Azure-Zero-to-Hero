# Azure VM Backup Workflow: Snapshots and Recovery Services Vault

When Azure Backup protects a virtual machine, the data does **not** go straight into the Recovery Services vault.  
Instead, Azure uses a **two-stage backup workflow**:

---

## 🟩 Stage 1 — Local Snapshot (Instant Restore Snapshot)

Azure first creates a **snapshot stored locally** in the VM’s disk storage.  
This snapshot:

- Exists **in the same region and storage cluster** as the VM disks  
- Enables **Instant Restore**  
- Is retained for the number of days defined in the backup policy  
- **Consumes storage in your subscription**  
- Is the main reason Instant Restore storage usage can grow quickly

This snapshot is *not* stored in the Recovery Services vault.

---

## 🟦 Stage 2 — Transfer to the Recovery Services Vault

After the snapshot is taken, Azure Backup copies the necessary blocks to the **Recovery Services vault**, which maintains:

- Daily or weekly restore points  
- Monthly retention  
- Yearly retention  

The vault is separate from local VM storage and is used for long-term recovery scenarios.

---

## 🌼 Why This Distinction Matters

Because snapshots stay in your VM storage, the **Instant Restore retention setting** directly affects:

- How much snapshot storage is used  
- How much you pay  
- How long Instant Restore data is available

Reducing snapshot retention reduces your local storage consumption.

---

## 🌟 Mental Model

- **Snapshot = Local + short-term + used for Instant Restore**  
- **Vault backup = Remote + long-term + used for recovery points**

Azure always performs:

1. **Local snapshot first**  
2. **Then vault transfer**

This model explains why Instant Restore storage usage can grow and how adjusting policy retention solves it.
