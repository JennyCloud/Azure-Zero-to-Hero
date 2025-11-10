# MiniLab 09 – VM Auto Start/Stop with Azure Automation Runbook

## 🎯 Goal
Automatically **stop** VMs at **11:00 PM** and **start** them at **7:00 AM** daily using an **Automation Account + Runbook** with a managed identity. This saves compute cost and demonstrates real-world scheduling + RBAC.

## 🧩 What I Built
- **Automation Account** with **system-assigned managed identity**
- **Runbook** (`StartStopVMs.ps1`) that takes `Start` or `Stop`
- **Two schedules:** `Stop-VMs-11PM` and `Start-VMs-7AM`
- **RBAC:** Managed identity has **Contributor** on the VM resource group

## 🛠 Prereqs
- Azure subscription
- 1+ VM in a resource group (demo: `AutoVMTest01` in `AutomationLab-RG`)
- Permissions to assign RBAC on the VM RG

## 📝 Steps (Portal)
1. **Resource Group**: Create `AutomationLab-RG` (or reuse).
2. **Automation Account**: Create `AutoVMRunbookLab` (enable **System-assigned identity**).
3. **RBAC**: On the **VM resource group**, grant **Contributor** to the Automation Account’s **Managed identity**.
4. **Runbook**: Create **PowerShell (5.1)** runbook `StartStopVMs`; paste script; **Publish**.
5. **Schedules**:
   - `Stop-VMs-11PM` → **Action = Stop** (daily)
   - `Start-VMs-7AM` → **Action = Start** (daily)

> Timezone: schedules use your portal’s local timezone.

## 🔎 Verification
- Manually **Start** the runbook with `Action = Stop` and view **Job Output**.
- VM status changes to **Stopped (deallocated)**.
- Activity Log shows **Deallocate/Start** initiated by the Automation Account identity.
- Next morning the VM is **Running** (from the schedule).

## 🧪 Optional Enhancements
- **Tag filter**: Control only VMs tagged `AutoSchedule=true`  
  - Add tag to VM: `AutoSchedule = true`  
  - Runbook params: `RequiredTagName=AutoSchedule`, `RequiredTagValue=true`
- **Multiple RGs**: Duplicate schedules per RG or extend script to loop RGs.
- **Notifications**: Add an Azure Monitor alert on job failure.

## 💰 Cost Notes
- **Compute** billing stops when **deallocated** ✅
- **Disks, snapshots, Standard Public IP** still bill as storage/network 🔎
