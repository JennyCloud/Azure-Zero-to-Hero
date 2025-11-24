# Troubleshooting Scenario #19 — Azure VM Cannot Access the Internet After Adding a Route Table (UDR)

## Situation
You have a virtual network with several subnets. Everything was working normally.  
Then a **route table (UDR)** is attached to a subnet, and suddenly the VM:

- Cannot reach the internet  
- `ping 8.8.8.8` fails  
- `curl` to external URLs fails  
- Windows Update stops working  
- VM extensions fail to install  
- Azure Backup fails  
- VM Agent shows **Not Ready**  
- Applications cannot reach external APIs  
- NSG flow logs show outbound traffic with no return  

In Effective Routes, you might see:

- `0.0.0.0/0 → Virtual Appliance`  
- `0.0.0.0/0 → None`

This is a very common AZ-104 scenario because one bad UDR silently kills all outbound connectivity.

---

## How to think about it

Azure route evaluation order:

1. **User-Defined Routes (UDRs)**  
2. **BGP routes**  
3. **System routes (default)**  

If a UDR defines:

0.0.0.0/0 → Virtual Appliance

or  
0.0.0.0/0 → None


…it **overrides** Azure’s default "Internet" route.

Result:

- No outbound internet  
- No inbound return traffic  
- No access to public endpoints  
- VM Agent cannot reach Azure  
- Extensions/Backup/Updates all fail  

---

## Most common causes

### 1. UDR sends all traffic to an offline or nonexistent firewall
Example:
0.0.0.0/0 → 10.0.0.4

If that firewall/NVA is offline → all outbound traffic dies.

---

### 2. UDR assigns default route to “None”
Example:
0.0.0.0/0 → None

This means:  
**“Drop all outbound traffic.”**

---

### 3. UDR overrides Azure’s system default route
Even if the firewall is online, if it has no outbound NAT → internet fails.

---

### 4. UDR applied to AzureBastionSubnet
Breaks Azure Bastion connectivity entirely.

---

### 5. Private endpoints + UDR mismatch
If DNS resolves to a private endpoint but UDR sends traffic to internet → failure.  
Or traffic meant for internet gets routed internally.

---

### 6. VM Agent and extension failures caused by lost outbound access
The VM Agent requires outbound 443 to:

- Azure Fabric  
- Azure Storage  
- Azure Backup  
- Extension sources  
- App repos (Windows Update, apt/yum updates)

If routing blocks outbound → agent immediately fails.

---

## How to solve it — admin sequence

### Step 1 — Check effective routes
VM → Networking → **Effective Routes**

Look for:

- `0.0.0.0/0 → Virtual Appliance`  
- `0.0.0.0/0 → None`  
- Missing “Internet” route  

This usually reveals the root cause instantly.

---

### Step 2 — Review the Route Table
Azure Portal → Route Table → Routes

Fix wrong entries:

#### Bad example:
0.0.0.0/0 → Virtual Appliance

(with NVA offline)

#### Good solutions:

**Option A — remove the UDR**  
If firewall isn’t required.

**Option B — restore internet route**
0.0.0.0/0 → Internet


**Option C — configure firewall correctly**  
Ensure firewall supports:

- Outbound SNAT  
- Internet access rules  
- Return traffic processing  

---

### Step 3 — Fix the next hop type
Ensure next hop is correct:

- “Internet” → for internet access  
- “Virtual Appliance” → requires working firewall  
- “None” → drops all traffic (almost always wrong)  
- “Virtual Network” → internal-only  

---

### Step 4 — Check the firewall (if used)
If using an NVA:

- Enable outbound NAT/SNAT  
- Allow outbound HTTP/HTTPS  
- Add rules for return traffic  
- Ensure appliance is reachable  

Firewalls often block outbound by default.

---

### Step 5 — NSG validation
NSGs must allow outbound:

- `AzureStorage`  
- `AzureMonitor`  
- `AzureBackup`  
- `AzureActiveDirectory`  
- `Internet`  
- `HTTPS (443)`  

Critical for VM Agent and extensions.

---

### Step 6 — Test from inside the VM

**Windows:**
Test-NetConnection www.microsoft.com -Port 443


**Linux:**
curl -I https://www.microsoft.com


---

### Step 7 — Re-run Azure operations
After fixing routing:

- VM Agent becomes Ready  
- Extensions install properly  
- Azure Backup works  
- Windows Update works  
- External APIs reachable  

---

## Why follow these steps?

Azure routing is strict:

1. **UDR overrides system routes**  
2. Wrong UDR breaks outbound traffic  
3. Broken outbound traffic breaks VM Agent  
4. VM Agent failure breaks Backup, Extensions, and Updates  
5. Fixing NSG cannot fix a wrong route  
6. Fixing firewall cannot fix a UDR pointing to “None”  

Troubleshooting out of order is inefficient:

- Fixing NSG doesn’t help if default route blackholes traffic  
- Restarting VM doesn’t fix routing  
- Reinstalling VM Agent fails without outbound internet  
- Updating firewall doesn’t help if UDR isn’t pointing to it correctly  

Routing is foundational — fix it first.

