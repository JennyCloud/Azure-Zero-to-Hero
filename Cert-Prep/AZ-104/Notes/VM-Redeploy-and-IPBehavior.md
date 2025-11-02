# ⚙️ Azure VM Redeploy & IP Behavior Explained

**Author:** Jenny Wang (@JennyCloud)  
**Category:** Azure Infrastructure | VM Management | Troubleshooting  

---

## 🧩 What Happens When You Redeploy a VM

When you **redeploy** an Azure Virtual Machine, Azure moves the VM to a **new physical host** within the same region.  
This helps fix host-level issues such as unresponsive VMs, hardware problems, or intermittent connectivity.

### ✅ What Stays the Same
- **OS Disk (C:)** – Stored in Azure Storage. Fully preserved.  
- **Data Disks** – Persist as managed disks.  
- **Local User Accounts** – Stored on the OS disk.  
- **Desktop Files, Wallpaper, and Configurations** – All remain intact on the OS disk.  
- **Networking Configuration** – NIC, subnet, and NSG assignments remain.

### ⚠️ What Is Lost
- **Temporary Disk (D:)** – The D: drive is *ephemeral storage* tied to the physical host.  
  Redeploying or deallocating the VM wipes it completely.  
- **Any Data Stored on D:** – Must not hold critical files, logs, or databases.

### 🧠 Analogy
> Think of C: as your **luggage** (persistent, travels with you)  
> and D: as the **hotel desk** (temporary, cleared when you move rooms).

---

## ☁️ Why Redeploy a VM

Redeploying is useful when:
- The VM is **stuck** or **unreachable** even though Azure reports it as “Running.”  
- There are suspected **hardware issues** on the host.  
- You need to **rule out host-level faults** before deep OS troubleshooting.  
- Azure Support recommends it to resolve **underlying compute instability**.

Redeployment = *same VM, new hardware*.

---

## 🌐 Public IP Behavior

### Dynamic Public IP
- Automatically assigned from Azure’s pool.  
- **Released** when the VM is stopped (deallocated).  
- A new IP will be assigned the next time the VM starts.

### Static Public IP
- **Reserved** for your subscription.  
- Persists through stop/deallocate/redeploy actions.  
- Involves a small ongoing charge for reservation.

### Quick Comparison

| Action | Dynamic IP | Static IP |
|:-------|:------------|:-----------|
| VM Running | Retained | Retained |
| VM Stopped (Deallocated) | Released | Retained |
| VM Redeployed | Retained (if running) | Retained |
| VM Deleted | Released | Released |

---

## 💡 Key Takeaways

- **Redeploying** moves your VM to a new host — **D: drive wiped**, everything else safe.  
- **Dynamic public IPs** are borrowed; **static IPs** are reserved.  
- Always store persistent data on **managed disks (C: or attached data disks)**.  
- For troubleshooting, redeploying is a **non-destructive reset** — safe but resets ephemeral resources.

---

🪶 *“Redeployment doesn’t rebuild your world — it just changes the ground beneath it.”*
