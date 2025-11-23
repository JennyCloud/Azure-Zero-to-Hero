# Troubleshooting Scenario #4 — Azure Files: SMB access fails

## Situation
You have a Windows VM in Azure. You’ve created an Azure Files share in a storage account. You try to mount the share using:

net use Z: \mystorageaccount.file.core.windows.net\myshare


But you get:

- “Access denied”  
- “The network path was not found”  
- “System error 53”  
- “System error 67”  
- Or endless SMB credential prompts  

This is one of the most common and most tricky AZ-104 troubleshooting cases.

---

## How to think about it

Azure Files using **SMB** depends on four things:

1. **Port 445 must be reachable**  
2. **Correct authentication**  
3. **Correct network routing**  
4. **Azure Storage firewall** not blocking your VM  

If any one is wrong → mounting fails.

The AZ-104 exam loves this one because small misconfigs completely break SMB.

---

## Most common causes of SMB failures

### 1. Port 445 is blocked
Azure Files **requires SMB over port 445**.

If your VM is:

- behind a corporate VPN  
- behind a firewall  
- in a locked-down NSG  
- using a secure environment  

Outbound 445 often gets blocked immediately.

Even Microsoft says:  
*"SMB access requires TCP port 445 to be open."*

If 445 is blocked → SMB = dead.

---

### 2. Using the wrong authentication method

Azure Files supports:

- **Storage account key**  
- **Azure AD DS (Kerberos)**  
- **Azure AD (native)** — newer model  

If your storage account is configured for **Azure AD DS auth**,  
but your VM is *not joined to the domain* → authentication fails.

If your storage account has **“Require secure transfer” enabled**  
and you try to use SMB 2.1 → also fails.

---

### 3. Storage firewall blocking your VM
If the storage account firewall is configured to “Selected Networks,”  
and the VM’s outbound IP isn’t included → blocked.

Classic symptom:  
“network path not found”

---

### 4. Incorrect DNS or custom DNS server
Azure Files endpoints:

`<accountname>.file.core.windows.net`

If DNS fails, SMB cannot resolve the UNC path.

Custom DNS servers often break this, especially when administrators forget the forwarders.

---

## How to solve it — the admin sequence

### Step 1 — Test port 445
On the VM:

Test-NetConnection mystorageaccount.file.core.windows.net -Port 445


If this fails → stop. SMB cannot work without 445.

You'll need:

- NSG rule allowing outbound 445  
- Firewall rule allowing outbound 445  
- No VPN blocking 445  

---

### Step 2 — Confirm the authentication method
Ask:

- Am I using **storage account key**? (always works)  
- Or **Azure AD DS**? (requires VM to be domain-joined)  
- Or **Azure AD**? (requires proper Azure role assignments)  

If auth method doesn't match VM state → SMB fails instantly.

---

### Step 3 — Check storage account firewall
Go to:

Storage account → Networking

Ensure:

- “Allow public access” is enabled  
or  
- VM’s outbound public IP is allowed  
or  
- VNet/subnet is allowed (private endpoint enabled)

---

### Step 4 — Check DNS resolution
Run:

nslookup mystorageaccount.file.core.windows.net


If DNS fails → UNC path cannot work.

Fix DNS forwarders if you're using custom DNS.

---

## Why follow these steps?

Because SMB relies on:

1. **Connectivity** (port 445)  
2. **Identity** (auth method)  
3. **Firewall** (storage side)  
4. **Resolution** (DNS)  

This is the actual packet + auth journey.

Checking out of order leads to traps:

- Fixing DNS won’t help if 445 is blocked.  
- Fixing firewall won’t help if authentication is mismatched.  
- Fixing authentication won’t help if routing blackholes SMB.  

You follow the sequence because it mirrors Azure’s real SMB path.
