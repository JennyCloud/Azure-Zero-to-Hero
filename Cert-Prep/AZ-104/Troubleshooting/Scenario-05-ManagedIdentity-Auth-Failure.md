# Troubleshooting Scenario #5 — Managed Identity authentication fails

## Situation
You have a VM, App Service, Function App, or Container App using a **system-assigned managed identity**.

You grant that identity **Storage Blob Data Reader**, **Key Vault Secrets User**, or similar.

Your code uses:
- Azure SDK  
- REST API  
- PowerShell with `Connect-AzAccount -Identity`  
- Or a script that expects MSI auth  

But it fails with:

- “Authentication failed”  
- “Unable to retrieve access token”  
- “MSI endpoint not found”  
- “403 Forbidden”  
- “The caller is not authorized”  
- “No such identity”  

Managed identity failures can be confusing because the identity looks simple — but relies on several moving parts.

---

## How to think about it

A managed identity works only if ALL of these are true:

1. The identity is **enabled**  
2. The identity exists in **Entra ID**  
3. The resource has **network access** to the IMDS endpoint  
4. The identity has **correct role assignments**  
5. The role assignment has **propagated**  

If any one of these is wrong → auth fails.

Think of MSI as a “magic cable” connecting your resource to Entra ID.  
If the cable is cut at any point, nothing works.

---

## Most common causes

### 1. Managed identity is enabled on the resource, but not granted RBAC permissions
You turn on the identity.  
You try to use it immediately.  
But you forget to assign:

- Storage Blob Data Contributor  
- Key Vault Secrets User  
- Reader  
- Contributor  
- etc.

Without RBAC = instant 403.

RBAC failure is the #1 cause.

---

### 2. Role assignment hasn’t propagated yet
RBAC propagation can take:

- 30 seconds  
- sometimes up to **5 minutes**  

During this time, MSI auth fails even though the permissions are “correct.”

This causes the classic:
> “I swear I added the role but it still fails!”

AZ-104 loves this detail.

---

### 3. The resource cannot reach the MSI endpoint (IMDS)
Every managed identity call hits:

`http://169.254.169.254/metadata/identity/oauth2/token`

If the VM/App:

- has an NSG blocking outbound to `169.254.169.254`  
- uses a firewall or proxy  
- uses custom routing (UDR → NVA)  
- has system-level restrictions  

…it cannot contact IMDS → MSI fails instantly.

---

### 4. Wrong identity type
Sometimes admins:

- use *user-assigned* identity but code expects *system-assigned*  
- or vice versa  
- or the assigned identity is removed  
- or the wrong identity is referenced in App Service configuration  

This leads to:
> “No such identity”  
> “Identity not found”  

---

### 5. Key Vault / Storage has its own firewall
Even if RBAC is correct, the resource may not be allowed through the firewall.

Example:
Key Vault → Networking → “Allow access from selected networks”

Your VM → not in selected networks  
→ blocked

You get:
> “Forbidden”  
> “Unable to retrieve secret”  

Even though MSI is perfectly fine.

---

## How to solve it — admin sequence

### Step 1 — Verify the identity exists and is enabled
Azure Portal → Resource → Identity  
Check:
- System-assigned = On  
- Or correct user-assigned identity is attached  

If not → MSI cannot work at all.

---

### Step 2 — Check RBAC role assignments
Azure Portal → Resource → Access control (IAM)  
Grant correct role:

- Blob Data Reader  
- Key Vault Secrets User  
- Contributor  
- etc.

Make sure it’s assigned to **the managed identity**, not your user account.

---

### Step 3 — Wait at least 30–60 seconds
MSI roles require propagation.  
This step avoids false negatives.

---

### Step 4 — Test IMDS access
From a VM:

Invoke-WebRequest -Uri http://169.254.169.254/metadata/instance
 -Headers @{Metadata="true"}


If this fails → MSI cannot authenticate.

For App Services / Functions, check:

- VNet Integration  
- NSG  
- Routes  
- Firewalls  

Anything blocking IMDS kills MSI.

---

### Step 5 — Check Key Vault / Storage firewall
Even with valid MSI authentication,  
the target service might block the request.

Go to:

Key Vault → Networking  
Storage → Networking  

Ensure:

- “Allow public access” enabled  
or  
- VNet/subnet listed  
or  
- Private endpoint configured  

---

## Why follow these steps?

Managed identity is a chain:

1. Identity must exist  
2. Identity must have RBAC rights  
3. Identity must reach IMDS  
4. Identity token must reach target resource  
5. Target resource must accept traffic  

If you check out of order:

- You'll chase Key Vault firewalls when IMDS was blocked  
- You’ll panic about RBAC when it just hasn't propagated yet  
- You’ll blame MSI when the identity wasn’t enabled  

You follow the sequence because each step reflects the real MSI authentication path in Azure.
