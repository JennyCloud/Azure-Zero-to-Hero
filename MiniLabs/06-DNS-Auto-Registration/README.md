# 🧭 Mini Lab 06 – Azure DNS Auto-Registration (Public vs. Private)

## 🎯 Goal
Understand how Azure handles **auto-registration** in **Private DNS Zones** versus **manual record management** in **Public DNS Zones**.

---

## 🧱 Environment Setup
**Resource Group:** `DNSLab-RG`  
**Region:** `Canada Central`

| Resource | Name | Notes |
|-----------|------|-------|
| Virtual Network | vnet1 | Address: 10.0.0.0/16, Subnet: 10.0.1.0/24 |
| VM 1 | vm1 (Windows Server 2019) | Public IP auto-assigned |
| VM 2 | vm2 (Ubuntu 22.04 LTS) | Used for DNS testing |
| Public DNS Zone | contosotest.com | (A real domain already exists globally) |
| Private DNS Zone | fabrikam.com | Linked to vnet1 with **auto-registration ON** |

---

## ⚙️ Steps Summary

### Step 1 – Create Resource Group
Portal → **Resource groups** → + Create →  
`DNSLab-RG` → Region = *Canada Central* → Create.

### Step 2 – Create Virtual Network
Portal → **Virtual networks** → + Create →  
Name = `vnet1` → Address = `10.0.0.0/16` → Subnet = `10.0.1.0/24`.

### Step 3 – Create Virtual Machines
1. **vm1 – Windows Server 2019**  
   - Username `azureuser` / Password `YourPassword123!`  
   - Same VNet/Subnet (vnet1/subnet1)  
   - Public IP: `vm1-pip`
2. **vm2 – Ubuntu 22.04 LTS**  
   - Username `azureuser` (SSH or password)  
   - Same VNet/Subnet (vnet1/subnet1)  
   - Public IP: `vm2-pip`

### Step 4 – Create DNS Zones
1. **Public Zone:** `contosotest.com`  
   *(This turned out to be a real domain on the Internet.)*  
2. **Private Zone:** `fabrikam.com`

### Step 5 – Link the Private DNS Zone
In `fabrikam.com` → **Virtual network links** → + Add  
→ Name `fabrikam-link` → VNet `vnet1` → ✅ Enable auto-registration.

---

## 🧩 Step 6 – Verify from Ubuntu (vm2)

From the Ubuntu VM, check the name resolution results.

I noticed that `vm1.fabrikam.com` resolves to a **private IP (10.0.1.4)** — proof of automatic registration through the Private DNS Zone.  
Meanwhile, `vm1.contosotest.com` surprisingly resolves to **45.41.88.73**, a public IP that belongs to a real, external domain.

---

## 🧠 What Happened?

- `vm1.fabrikam.com` was resolved *inside Azure* through the Private DNS Zone linked to the VNet.  
- `vm1.contosotest.com` wasn’t found in Azure, so the query was forwarded to **public DNS root servers**, which returned a **real Internet record** belonging to someone else.

That means `contosotest.com` is an *actual public domain*, and my VM just looked it up globally.

---

## 🔬 Technical Breakdown

| Component | Behavior |
|------------|-----------|
| `/etc/resolv.conf` | Points to `127.0.0.53` → `systemd-resolved` → Azure DNS (168.63.129.16) |
| Azure DNS | Checks for private zone → If not found, forwards to public DNS |
| Public DNS | Returns the real record from Internet root servers |
| Result | You got a public IP (`45.41.88.73`) you don’t own |

---

## 🧰 Lesson Learned
1. **Private DNS Zones** = auto-registration inside VNets (internal use).  
2. **Public DNS Zones** = manual record creation only.  
3. **Existing domains** = DNS will resolve real records unless you own that domain.  
4. For safe lab testing, use domains like:
   - `contoso.local`
   - `lab.internal`
   - `demo.private`
   - or unique, unregistered names like `contosolab.ca`.

---

## 🧾 Summary

| Zone Type | Auto-Registration | IP Type | Behavior |
|------------|------------------|----------|-----------|
| Private (fabrikam.com) | ✅ Yes | Private IP | Auto-created A records |
| Public (contosotest.com) | ❌ No | Public IP | No Azure record; resolved to real Internet domain |

---

## 🧠 Reflection
Azure DNS follows global DNS hierarchy rules — not just your subscription.  
So when a “test domain” exists publicly, your Azure VM might return *real* results from the global DNS system.  
It’s a fascinating reminder that in networking, **names have consequences** — even in labs.
