# Troubleshooting Scenario #1 — VM cannot reach a storage account

## Situation
You have a VM in a virtual network. The VM suddenly cannot access a storage account (for example, cannot download a file or connect via SMB to Azure Files). The storage account uses **public network access**, not private endpoints.

You need to figure out what’s blocking the connection.

---

## How to think through it (the admin way)

Networking failures in Azure almost always follow the same three suspects:

1. **NSG** (Network Security Group)  
   The VM’s subnet or NIC NSG may block outbound traffic.  
   Storage needs port **443** for almost everything — Blob, File (plus 445 for SMB).

2. **Firewall rules on the storage account**  
   If the storage firewall allows only “Selected Networks,” the VM’s **public outbound IP** might not be listed.  
   Hidden trap:  
   The VM’s outbound IP may have changed because it’s using **default outbound IP** or **load balancer NAT**.

3. **DNS resolution problems**  
   If the VM uses a custom DNS server that isn’t resolving `*.blob.core.windows.net`, access breaks instantly.

---

## How you solve it

Follow this flow like a detective:

### Step 1 — Check NSG rules
Confirm the VM can go out to `443` (always) and `445` (only if accessing Azure Files via SMB).

### Step 2 — Check storage account firewall
Go to:  
Storage Account → Networking → Firewall & virtual networks  
Verify:  
- “Allow public access from…”  
- VM’s outbound IP is in the allowed list

### Step 3 — Confirm outbound IP
Azure Portal → VM → Networking → Outbound IP  
Make sure it's the one you expect.

### Step 4 — Test DNS resolution
Inside the VM run:  
`nslookup <storageaccountname>.blob.core.windows.net`  
If DNS fails, nothing else matters.

---

## Why AZ-104 likes this scenario

Because it checks whether you understand **the real Azure failure chain**:  
Security → Firewall → NAT → DNS.

Admins that don’t check all four chase ghosts.

---

# Why should you follow these steps?

When people say “check NSG,” “check firewall,” “check DNS,” it can sound like a ritual. It isn't. There’s a very logical reason for the order — it mirrors **how traffic actually travels inside Azure**.

---

## Why this exact troubleshooting sequence works

### 1. NSG check comes first
Think of NSGs (Network Security Groups) as **Azure’s bouncers standing at the club door**.  
If they say “no outbound traffic,” nothing leaves the VM.  
It won’t even reach the storage account to get rejected later.

Skipping this is like calling the restaurant asking why your food isn’t arriving while your front door is locked from the inside.

---

### 2. Storage firewall check comes next
Even if the VM is allowed to leave, the storage account might say:  
"You're not on my VIP list."

Azure Storage firewalls look at the caller’s **public outbound IP**.  
If it’s not allowed, access is denied.

This is the second gate.

Skipping this is like blaming your router when the website itself is saying “403 forbidden.”

---

### 3. Outbound IP check is third
Azure VMs can have *surprise* outbound IP changes if:

- they don’t have a static public IP  
- they sit behind a load balancer  
- they use Azure’s default outbound access

So even if your NSG is open and the storage firewall has a rule,  
your VM’s outbound IP might secretly be different today.

That means the firewall rule is now pointing at the wrong person.

This is the “plot twist” of Azure networking.

---

### 4. DNS check is last
DNS is the phonebook.

If DNS can’t turn  
`mystorageaccount.blob.core.windows.net`  
into an IP, the VM has nowhere to send packets.

Doing this step first is often useless, because if NSG/firewall already block traffic, DNS results won’t fix anything.

This is the final check because it confirms:  
"Can my VM actually look up where it wants to go?"

---

## Why this order matters
Azure networking problems behave like **a series of nested doors**.

1. NSG must let you out.  
2. Storage firewall must let you in.  
3. Outbound IP must match what the firewall expects.  
4. DNS must tell you the correct address.

If you skip steps or check in the wrong order, you get misled — badly.

Troubleshooting becomes like trying random keys in random doors.

---

## The deeper reason: AZ-104 tests your sequence thinking

Azure errors rarely tell you the real cause; they only show the *last door* that closed.

Following this order forces your brain to think like Azure’s traffic flow.
