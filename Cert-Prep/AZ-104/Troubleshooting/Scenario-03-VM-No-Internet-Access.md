# Troubleshooting Scenario #3 — VM cannot access the internet

## Situation
You deploy a new VM in a virtual network. The VM boots, RDP/SSH works, it can talk to internal resources, but **it cannot reach the internet**.

Commands like:

- `ping 8.8.8.8`
- `curl https://microsoft.com`
- `apt-get update`

and Windows Update all fail.

This is one of the most classic and sneaky AZ-104 troubleshooting questions.

---

## How to think about it

Azure VMs reach the internet through a specific chain:

1. VM → subnet  
2. Subnet → outbound rules  
3. Route table (if any)  
4. NAT (public IP or Azure’s default outbound access)  
5. NSGs  
6. Firewall (if you have Azure Firewall or NVA)  
7. DNS  

If any link breaks, the whole chain collapses.

Internet failures are rarely random — they usually follow the same 3 culprits.

---

## Most common reasons a VM has no internet

### 1. The VM is in a subnet with a User-Defined Route (UDR) that breaks outbound traffic
This is the BIG one.

Someone adds a route table with:

- `0.0.0.0/0 → Virtual Appliance` (run through a firewall that isn’t working), or  
- `0.0.0.0/0 → None` (accidentally blackholing outbound traffic)

Instant internet death.

---

### 2. Missing or misconfigured NAT / public outbound path

Azure allows outbound traffic in three ways:

- A public IP on the VM  
- A public IP on a load balancer  
- Azure default outbound (when no public IP exists)  

If the VM is inside a NAT gateway, but NAT isn’t associated with the subnet → no outbound.

If someone disabled default outbound access → no outbound.

If the VM was behind a load balancer but the LB SKU changed → outbound breaks.

---

### 3. NSG rules blocking outbound traffic

Outbound security rule:

`Deny All`  
or  
`Deny Internet`

…will stop everything.

Some admins mistakenly add:

- Allow RDP/SSH  
- Deny everything else  
- Forget outbound traffic exists  

The VM can be reached from outside but cannot reach anything outside.

---

## How to solve it — the admin sequence

### Step 1 — Check the VM’s effective routes
Azure Portal → VM → Networking → **Effective Routes**

Look for:

- UDR sending `0.0.0.0/0` to an offline firewall  
- `0.0.0.0/0 → None` (blackhole)  
- Missing default internet route through `Internet`  

This step immediately reveals routing problems.

---

### Step 2 — Check NAT / public outbound configuration

Confirm one of these is true:

- VM NIC has a public IP  
- Subnet has a NAT gateway  
- VM is behind a standard load balancer with outbound rules  
- VM is allowed to use default outbound access  

If all are false → there is **no valid outbound path**.

---

### Step 3 — Check NSG outbound rules

Look for:

- `DenyAllOutbound`  
- `DenyInternet`  
- Priority rules accidentally overriding allows  

Outbound rules block more often than people realize.

---

### Step 4 — Check DNS (only after routing is fixed)

If NSG, NAT, and routes are fine, try:

`nslookup microsoft.com`

DNS issues prevent browsing even if raw IPs work.

---

## Why these steps?

Azure traffic is sequential — routing decides where packets go, NAT decides how they leave, NSG decides if they’re allowed.

Checking in any other order creates confusion.

Fixing DNS won’t matter if routing is wrong.  
Fixing NSG won’t matter if NAT is missing.  
Fixing NAT won’t matter if UDR sends everything into a firewall black hole.

You follow the packet’s journey.
