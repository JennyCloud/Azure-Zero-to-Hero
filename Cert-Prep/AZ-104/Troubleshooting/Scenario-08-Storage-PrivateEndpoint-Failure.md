# Troubleshooting Scenario #8 — Azure Storage: Private Endpoint breaks access

## Situation
You have a Storage Account. Everything used to work:

- VMs could upload/download blobs  
- Scripts worked  
- App Service worked  
- Azure Functions worked  

Then you enable a **Private Endpoint** for the storage account.

Suddenly:

- Apps cannot access `https://mystorage.blob.core.windows.net`  
- VMs get **403 Forbidden**  
- App Service gets **connection timeout**  
- Scripts using AzCopy or SDK fail  
- Public network access seems broken  

This is one of the most common real-world Azure issues and a favorite AZ-104 exam scenario.

---

## How to think about it

Turning on a **private endpoint** changes the entire access model.

Storage now has:

1. A **private IP** inside your VNet  
2. A forced DNS override using `privatelink` zone  
3. Public endpoint usually blocked  
4. A dependency on VNet routing, NSGs, and DNS  

If anything in this chain is missing → storage becomes unreachable.

---

## Most common causes

### 1. Public network access disabled, but the clients aren’t in the VNet
When you create a private endpoint, many admins also enable:

> “Disable public network access”

Now **only** the private IP can be used.

If your client:

- VM without correct DNS  
- App Service without VNet Integration  
- Function App not in the same VNet  
- On-prem (VPN/ExpressRoute) without DNS resolution  

…the request still tries to go to `*.blob.core.windows.net` → public endpoint → blocked.

This is the #1 cause.

---

### 2. Missing or incorrect Private DNS zone
Private endpoints rely on this zone:

`privatelink.blob.core.windows.net`

If you don’t:

- create the zone  
- link it to your VNet  
- allow auto-registration  

…your clients will NOT resolve the private IP.

Without DNS, clients hit the *public* endpoint — which is usually disabled.

---

### 3. App Service / Function doesn’t have VNet integration
App Service cannot use private endpoints unless:

- VNet Integration is enabled  
- The VNet has DNS config that resolves the `privatelink` zone  

No VNet Integration = no way to reach the private endpoint.

---

### 4. NSG or route table blocking traffic to the private endpoint subnet
Private endpoints sit inside a special subnet.  
If that subnet has:

- NSG blocking storage port traffic  
- UDR sending traffic to an NVA that doesn’t allow it  

…the private endpoint cannot be reached.

---

### 5. Mixing public and private endpoint usage
If you have:

- Shared access signature URLs  
- AzCopy scripts  
- Applications  
- Services  

…using **public URLs**, they may break once private access is enforced.

---

## How to solve it — the admin sequence

### Step 1 — Check storage network configuration
Storage Account → Networking

Look for:

- Public network access: Enabled? Disabled?  
- Selected networks?  
- Correct private endpoints?  

If public access is disabled → all clients must use the private endpoint.

---

### Step 2 — Check Private DNS zone
Go to:

Private DNS zones → `privatelink.blob.core.windows.net`

Check:

- Does the zone exist?  
- Is the VNet linked?  
- Does it contain the A record for your storage account?  

If no → DNS cannot resolve private endpoint → access fails.

---

### Step 3 — Validate DNS resolution from the client
From a VM:

nslookup mystorageaccount.blob.core.windows.net


Expected: A private IP in your VNet (10.x / 172.x / etc.)  
If you see a public IP → DNS is wrong.

From App Service (Kudu):

nslookup mystorageaccount.blob.core.windows.net


If this fails → fix VNet Integration or DNS.

---

### Step 4 — Check VNet Integration for App Service / Function
App → Networking → VNet Integration

Ensure:

- Correct VNet  
- DNS configured on VNet  
- No misconfigured UDRs  

Without integration → private endpoints cannot be reached.

---

### Step 5 — Check NSG and route table on the private endpoint subnet
The private endpoint subnet should:

- NOT have a UDR forcing traffic to a firewall  
- NOT block inbound/outbound to storage’s private IP  
- Allow 443  

If traffic cannot reach the private IP → storage access fails.

---

### Step 6 — Validate client type
If the client is:

- On-prem  
- A local machine  
- Azure DevOps self-hosted agent  
- GitHub runner  

It MUST have:

- DNS resolution for the private zone  
- A network path (VPN/ExpressRoute)  

Without DNS override → traffic still tries to hit the public endpoint.

---

## Why follow these steps?

Private endpoint failures always come from one of these checkpoints:

1. **Public endpoint allowed?** If not, all traffic must be private.  
2. **DNS override working?** Private endpoints need `privatelink` DNS.  
3. **Client in VNet?** If not, it cannot use private access.  
4. **Routing correct?** UDR must not hijack traffic.  
5. **Firewall/NSG correct?** Must allow 443 to private endpoint.  

If you check these out of order:

- You may fix NSG when DNS was the problem  
- You may fix DNS when public access was intentionally disabled  
- You may fix routing for an App Service that isn’t even in a VNet  
- You may check firewall on the wrong side  

The sequence mirrors the **actual path** a private endpoint request follows.
