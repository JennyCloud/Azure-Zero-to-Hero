# Troubleshooting Scenario #11 — Azure Key Vault: Application can’t retrieve a secret

## Situation
An application (VM, App Service, Function App, Container App, AKS pod, Logic App) tries to retrieve a secret from **Azure Key Vault**.

But it fails with:

- “Forbidden”  
- “Access denied”  
- “Client not authorized to perform action”  
- “Unable to retrieve secret from vault”  
- “The user, group, or application does not have secrets get permission”  
- Timeout errors  

This is a major AZ-104 exam scenario because Key Vault depends on:

**RBAC + Access Policies (legacy) + Network rules + Private endpoints + DNS + Managed Identity**

One small mismatch → total failure.

---

## How to think about it

To successfully read a secret from Key Vault, your client must pass ALL of these gates:

1. **Identity exists** (Managed Identity or Service Principal)  
2. **Identity has Key Vault permissions** (RBAC or Access Policy)  
3. **Client can reach Key Vault endpoint** (public or private)  
4. **DNS resolves Key Vault correctly** (public or privatelink)  
5. **Firewall allows the request**  

If ANY gate denies access → the entire request fails.

---

## Most common causes

### 1. You’re using RBAC but no role assigned
Modern Key Vault often uses RBAC instead of Access Policies.

Required roles include:

- Key Vault Secrets User  
- Key Vault Secrets Officer  
- Key Vault Administrator  
- Key Vault Reader (but cannot read secret values!)  

If your managed identity only has **Reader**, it cannot read secret values.

403 is guaranteed.

---

### 2. You’re using Access Policies but didn’t assign “Get” permission
Older Key Vaults use Access Policies.

To read a secret, the identity must have:

- Secret → Get  
- (optionally List)  

If missing → access denied.

---

### 3. The identity being used is NOT the one you think
Common mistakes:

- App Service uses system-assigned MI, but you assigned roles to a user-assigned MI  
- VM uses system-assigned MI, but code uses wrong client ID  
- Function App uses identity but it is disabled  
- AKS pod uses wrong workload identity  

Identity mismatch = instant failure.

---

### 4. Key Vault firewall blocks the client
Key Vault networking has settings:

- Allow public access  
- Selected networks only  
- Private endpoint only  

If public access is disabled → only private endpoint works.

If client isn’t in allowed VNets → blocked.

Classic symptom:  
“Timeout” instead of “Forbidden.”

---

### 5. DNS resolving to wrong endpoint
If you use a private endpoint but DNS still resolves to the public endpoint:

- App Service fails  
- VM fails  
- Functions fail  
- MSI lookup fails  

Private endpoints **must** use:

`<vault>.privatelink.vault.azure.net`

If they resolve the public endpoint → request gets blocked.

---

### 6. Client cannot reach Azure IMDS (for managed identity)
All MSI authentication depends on IMDS:

`http://169.254.169.254/metadata/identity/oauth2/token`

If blocked by NSG, firewall, UDR → MSI cannot obtain token → Key Vault access fails.

---

## How to solve it — the admin sequence

### Step 1 — Check which identity the client uses
Verify in the resource:

- VM → Identity  
- App Service → System-assigned / User-assigned identity  
- Function App → Identity  
- AKS → Managed identity or workload identity  

Make sure THIS identity is the one you granted permissions to.

---

### Step 2 — Verify Key Vault permissions
Check if Key Vault uses:

- **RBAC** (preferred)  
- **Access Policies** (legacy)  

Then confirm:

- For RBAC → correct “Secrets User” or higher  
- For Access Policies → Secret: Get  

Missing permissions = 403.

---

### Step 3 — Check Key Vault firewall
Key Vault → Networking

Check:

- Public network access: Enabled?  
- Selected networks only?  
- Private endpoint configured?  

If public access is disabled → client MUST reach private endpoint.

---

### Step 4 — Validate DNS
From client VM or Kudu Console:

nslookup myvault.vault.azure.net


Should return **either**:

- A public IP (if using public access)  
- A private IP (if using private endpoint)  

If DNS resolves incorrectly → fix DNS or private zone linking.

---

### Step 5 — Test MSI token
For VM:

curl http://169.254.169.254/metadata/identity/oauth2/token?resource=https://vault.azure.net
 -H Metadata:true


If this fails → MSI cannot authenticate.

Fix:

- NSG blocking IMDS  
- UDR misrouting 169.254.169.254  
- Identity disabled  

---

### Step 6 — Check VNet + private endpoint path
If using private endpoint:

- Subnet must allow 443  
- No UDR sending traffic to firewall  
- DNS zone must be linked properly  

---

## Why follow these steps?

This exact order matches the **authorization + networking pipeline**:

1. **Identity** – Who are you?  
2. **Key Vault permission** – Are you allowed?  
3. **Networking** – Can you reach me?  
4. **DNS** – Do you know where I am?  
5. **MSI / token** – Can you authenticate?  
6. **Private endpoint** – Can you reach my IP?  

If you troubleshoot out of order:

- You may debug firewall rules when RBAC was the issue  
- You may fix MSI when DNS was wrong  
- You may test private endpoint connectivity when Access Policy was missing  
- You may check DNS when identity was disabled  

This sequence ensures you don’t chase ghosts.
