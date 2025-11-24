# Troubleshooting Scenario #14 — Azure VM: RDP or SSH suddenly stops working

## Situation
You have a VM that was working perfectly. Suddenly:

- You cannot RDP (Windows)  
- You cannot SSH (Linux)  
- Connection hangs or times out  
- Bastion may or may not work  
- Apps might still run, but admin access is gone  
- Or all connectivity stops entirely  

This is one of the most realistic AZ-104 troubleshooting scenarios because VM access depends on multiple layers: NSG → UDR → OS firewall → VM health.

---

## How to think about it

RDP/SSH connectivity relies on this chain:

1. **Public IP or private IP reachable**  
2. **NSG allows inbound traffic**  
3. **Route table sends traffic to correct next hop**  
4. **Operating system firewall allows inbound traffic**  
5. **The VM itself is healthy and running**  
6. **VM agent functioning properly**  

If **any** of these fail, you lose access.

---

## Most common causes

### 1. NSG blocks RDP or SSH
Common errors:

- Deny All inbound  
- Removed allow rule for 22 (SSH) or 3389 (RDP)  
- Wrong priority ordering  
- Deny Internet before allow rule  

This is the most common failure.

---

### 2. UDR (route table) breaks connectivity
A misconfigured route such as:

0.0.0.0/0 → Virtual appliance


and the appliance is offline → no RDP/SSH.

Or:

10.0.0.0/16 → None


→ VMs in same VNet can't talk to each other.

---

### 3. OS firewall blocks the port
Windows Firewall may block:

- inbound 3389  
- RDP service disabled  

Linux iptables/UFW may block:

- inbound 22  
- rate-limit or ban IPs (fail2ban)  

---

### 4. Public IP missing or removed
Without a public IP, external RDP/SSH cannot work unless:

- Bastion is used  
- VPN/ExpressRoute exists  

Admins often remove the public IP unintentionally.

---

### 5. VM boot or OS failure
If the OS is stuck:

- Blue screen  
- GRUB rescue  
- Failed updates  

RDP/SSH cannot start.

---

### 6. VM agent corrupted
Causes:

- Extensions cannot run  
- Reset operations fail  
- Serial console fails in some cases  

---

### 7. NIC or subnet misconfiguration
Moving NICs, removing NICs, or changing subnets breaks routing and DHCP.

---

### 8. Bastion subnet misconfigured
If using Bastion:

- Wrong subnet name (`AzureBastionSubnet`)  
- NSG applied to Bastion subnet  
- UDR blocking Bastion traffic  

You lose Bastion access too.

---

## How to solve it — admin sequence

### Step 1 — Use Azure “Check VM” diagnostic
VM → “Connect” → Troubleshoot RDP/SSH  
Azure checks:

- NSGs  
- Public IP  
- Boot status  
- Agent issues  

This is the fastest initial step.

---

### Step 2 — Check NSGs
Check both:

- NIC NSG  
- Subnet NSG  

Rules must allow:

- **Port 3389** for RDP  
- **Port 22** for SSH  
- Source: Any or your IP  
- Priority above Deny rules  

---

### Step 3 — Check effective routes
VM → Networking → **Effective Routes**

Look for:

- `0.0.0.0/0 → Virtual appliance`  
- `0.0.0.0/0 → None`  
- Missing “Internet” route  
- Unexpected UDR overrides  

---

### Step 4 — Check OS firewall
Using Serial Console or Bastion:

Windows:
Get-NetFirewallRule | findstr RDP

Linux:
sudo iptables -L
sudo ufw status


---

### Step 5 — Check boot diagnostics
VM → Boot Diagnostics  
Look for:

- Blue screen  
- GRUB errors  
- "Provisioning failed"  

If OS can't boot → no RDP/SSH.

---

### Step 6 — Reset NIC
VM → Networking → **Reset network interface**

Fixes:

- Broken NIC  
- Missing default gateway  
- DHCP issues  

---

### Step 7 — Reset RDP/SSH configuration
VM → Run Command:

- **Reset RDP** (Windows)  
- **Reset SSH** (Linux)  

---

### Step 8 — Reset admin password
If connection works but login fails, reset credentials.

---

### Step 9 — Use Serial Console
If VM agent and OS are responsive:

- Restart RDP/SSH service  
- Modify firewall rules  
- Fix OS configuration  

---

### Step 10 — Rebuild VM disk (last resort)
Detach OS disk → attach to rescue VM → repair OS → reattach.

---

## Why follow these steps?

RDP/SSH issues follow a strict dependency order:

1. **Network path → NSG/UDR/Public IP**  
2. **OS inbound permissions → firewall**  
3. **VM health → boot diagnostics**  
4. **Identity/services → reset credentials**  
5. **Disk-level recovery → last resort**

Troubleshooting out of order creates confusion:

- Fixing OS firewall won't help if NSG denies port  
- Fixing NSG won't help if route table blackholes traffic  
- Resetting password won't help if no public IP  
- Resetting RDP won't help if the OS won't boot  

Following the pipeline ensures you fix the real problem.
