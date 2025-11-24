# Troubleshooting Scenario #10 — Azure Firewall / NSG: VM cannot reach internet or other subnets after adding a route table

## Situation
Your virtual network was working perfectly:

- VMs could reach the internet  
- VMs could talk to each other  
- Apps could reach external APIs  
- Storage access worked  

Then someone attaches a **route table (UDR)** to a subnet.

Suddenly:

- VM cannot access the internet  
- VM cannot reach other subnets  
- App Service or Functions behind VNet Integration stop working  
- Storage or Key Vault access over private endpoints fails  
- Everything becomes slow or times out  

This is one of the most common and painful AZ-104 troubleshooting scenarios.

---

## How to think about it

When you attach a route table, you change **Azure’s system routing**.  
The moment you override a route, Azure’s default behaviors disappear.

One wrong UDR can blackhole an entire subnet.

Classic symptom:  
“Everything worked before we added the route table.”

---

## Most common causes

### 1. A 0.0.0.0/0 route forces all outbound traffic to a firewall or NVA
This is the **#1 cause**.

Example route:

0.0.0.0/0 → Virtual appliance (10.0.100.4)


If that appliance:

- is powered off  
- crashed  
- doesn’t allow the traffic  
- is misconfigured  

→ Your entire subnet loses internet.

---

### 2. A 0.0.0.0/0 route breaks access to Azure services
Many Azure services (Storage, Key Vault, ACR, etc.) are reached **by public IP** unless you use private endpoints.

If your default route forces everything into a firewall, but the firewall doesn’t know Azure’s service tags → you break:

- Storage access  
- Key Vault access  
- Managed identity  
- Updates  
- Windows activation  
- Package downloads (apt/yum/choco)  

---

### 3. The route table blocks VirtualNetwork traffic
If someone mistakenly adds:

10.0.0.0/16 → None


(or sends it to a wrong appliance)

→ VMs in the same VNet cannot talk to each other.

---

### 4. Conflicting UDR with Private Endpoints
Private endpoints require a route to **their private IP**.

If you add a UDR that overrides:

- `168.63.129.16`  
- `169.254.169.254`  
- the PE subnet IPs  

→ Private endpoints and Azure IMDS break, causing:

- Managed identity failures  
- Key Vault failures  
- Storage failures  

---

### 5. App Services using VNet Integration inherit broken routes
When App Service uses VNet Integration, it inherits:

- NSGs  
- UDRs  
- Firewalls  

If your UDR hijacks outbound:

→ App Service loses internet or DB access.

---

## How to solve it — the admin sequence

### Step 1 — Check effective routes
Azure Portal → VM → Networking → **Effective Routes**

Look for:

- `0.0.0.0/0 → Virtual appliance`  
- `0.0.0.0/0 → None`  
- Any surprising routes  
- Conflicts with system routes  

If system routes disappear → UDR is overriding everything.

---

### Step 2 — Check the NVA (firewall)
If `0.0.0.0/0` is forced to an appliance:

- Is the appliance online?  
- Does it allow outbound 443?  
- Does it allow DNS?  
- Does it have routes back to the VNet?  

NVAs often break traffic because they require full routing design.

---

### Step 3 — Remove or modify the 0.0.0.0/0 route
If it’s not required:

- Remove it  
- Or change the route to specific prefixes  
- Or use **Azure Firewall** which integrates with Azure service tags  

Internet access returns instantly once default outbound is restored.

---

### Step 4 — Restore Azure defaults
For VM internet access, system route must be:

0.0.0.0/0 → Internet


If a UDR overrides this, Azure will not fallback automatically.

---

### Step 5 — Verify NSGs aren’t blocking outbound
Even with correct routes, NSGs can block outbound:

- Deny Internet  
- Deny All  
- Application rules blocking SMB/HTTPS  

Always check:

- NIC NSG  
- Subnet NSG

---

### Step 6 — Check DNS resolution
If DNS fails after a routing change:

- Fix custom DNS servers  
- Fix private DNS zones  
- Allow 53/UDP to your DNS resolver  

---

## Why follow these steps?

Routing failures follow a precise hierarchy:

1. **Effective routes** — what the VM *actually uses*  
2. **NVA / Firewall health** — traffic may be forced to a dead appliance  
3. **NSGs** — may block connectivity AFTER routing  
4. **DNS** — resolves endpoints AFTER routing & firewall  
5. **Azure services** — depend on all layers being correct  

If you debug these out of order:

- You may chase DNS even though traffic is blackholed  
- You may blame NSGs when routing is wrong  
- You may check the VM when the firewall died  
- You may debug the app when the subnet is misrouted  

This sequence follows the actual path packets take in Azure networking.
