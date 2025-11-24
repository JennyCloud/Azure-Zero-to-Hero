# Troubleshooting Scenario #20 — Azure VM Cannot Start Because “Host Allocation Failed” (Quota, Capacity, or SKU Availability Issue)

## Situation
You attempt to **start**, **create**, **resize**, or **redeploy** an Azure Virtual Machine.  
Instead of coming online, Azure returns errors such as:

- **Allocation failed**  
- **Host allocation failed**  
- **There are not enough suitable hosts**  
- **No capacity available for the requested VM size in this region**  
- **The requested VM size is not available in the availability zone**  
- **OverconstrainedAllocationRequest**  
- **The resource quota has been exceeded**

The VM remains in:

- “Starting” → “Stopped”  
- “Failed” provisioning  
- “Deallocated” state  

This is a very common real-world and AZ-104 exam scenario because VM SKU availability varies by region, zone, and physical cluster.

---

## How to think about it

When starting or resizing a VM, Azure must locate physical compute capacity that matches ALL of the following:

1. **VM size (SKU)**  
2. **Region**  
3. **Availability Zone**  
4. **Fault/Update Domain placement** (if using Availability Sets)  
5. **Required hardware features** (accelerated networking, premium disk support, GPU, etc.)  
6. **Subscription vCPU quota**

If **any one** of these constraints cannot be met → **allocation fails**.

Even if a region is open, the **specific cluster** you're tied to may have no available nodes for that VM size.

---

## Most common causes

### 1. VM size no longer available
Older or specialized SKUs may be retired or capacity-limited:

- A-series  
- DS_v2 series  
- Older D-series variants  
- Large GPU sizes  

---

### 2. VM size not available in selected Availability Zone
Example:

- You choose Zone 1  
- But SKU exists only in Zone 2 or Zone 3  

Allocation fails due to zone constraint.

---

### 3. vCPU quota exhausted
Example:

- Subscription allows 20 vCPUs for D-series  
- You already use 18  
- You try to deploy a 16-vCPU VM  

→ Quota exceeded.

---

### 4. Availability Set placement constraints
Availability Sets enforce:

- Fault Domain distribution  
- Update Domain distribution  

If Azure cannot place a new VM into required domains, allocation fails.

---

### 5. Insufficient capacity in the exact cluster
Even when a VM size is supported region-wide:

- The **cluster hosting your VM** may not have spare capacity  
- This is common after resizing or redeploying

---

### 6. OS disk requiring hardware not supported by chosen SKU
Examples:

- OS disk uses **Ultra Disk** but VM size doesn’t support Ultra  
- Using accelerated networking with SKU that does not support it

---

### 7. Spot VM capacity issues
Spot VMs are evicted when capacity is low.  
Restarting a Spot VM may repeatedly fail.

---

## How to solve it — admin sequence

### Step 1 — Check vCPU quota
Azure Portal → Subscriptions → **Usage + quotas**

If insufficient quota for the VM family:

- Request a quota increase  
- Or switch to a different SKU family

---

### Step 2 — resize to a supported VM size
Choose a SKU with strong availability:

- D_v5  
- D_a_v5  
- B-series (for small workloads)  
- Newer v4/v5 sizes  

Avoid older SKUs.

---

### Step 3 — remove Availability Zone constraint
Try:

- Moving VM to “No zone”  
- Deploying into a different zone  
- Recreating VM in a zone that supports the SKU

---

### Step 4 — remove Availability Set constraint  
If VM is in an Availability Set:

- You **cannot** change the set  
- The only fix is:
  - Create a new VM **from the existing disk** outside the Availability Set  
  - Or deploy a new VM with different availability strategy

---

### Step 5 — Redeploy the VM  
VM → **Redeploy**

This moves VM to a different physical host, sometimes resolving cluster capacity issues.

---

### Step 6 — Move VM to a different region  
If region-wide capacity is low:

- Snapshot OS disk  
- Create VM in another region  
- Or use Azure Site Recovery to replicate and fail over

---

### Step 7 — remove hardware constraints
Examples:

- Disable Accelerated Networking  
- Change OS disk from Ultra to Premium SSD  
- Remove GPU requirement  
- Reduce memory or CPU count

---

### Step 8 — Switch from Spot to Regular VM
If you're using Spot, restart failures are normal under capacity pressure.

Switch to Standard VM to restore service reliability.

---

## Why follow these steps?

VM allocation errors follow this strict sequence:

1. **Quota must be sufficient**  
2. **SKU must exist in the region**  
3. **SKU must exist in the availability zone**  
4. **Cluster must have capacity**  
5. **Hardware constraints must match the host**  
6. **Availability Set requirements must be satisfiable**  

Troubleshooting any other order wastes time:

- Increasing quota does nothing if SKU isn’t available in that zone  
- Redeploying does nothing if the cluster lacks capacity  
- Changing zones does nothing if GPU or Ultra Disk requirements mismatch  
- Fixing constraints does nothing if Availability Set is overconstrained  

Correct order = **Quota → SKU → Zone → Cluster → Constraints → Availability Set**.

