# Troubleshooting Scenario #13 — Azure Function App: Fails to access Storage Account

## Situation
An **Azure Function App** suddenly stops working.

You see errors like:

- “The function runtime is unable to reach the storage account.”  
- “The storage account connection string is invalid.”  
- “Unable to access storage for triggers”  
- “Host lock lease cannot be acquired”  
- “Microsoft.WindowsAzure.Storage: Server failed to authenticate the request.”  
- Timeouts when accessing storage  

Your function won’t start, triggers won’t fire (Queue, Timer, Blob), and the app may constantly restart.

This is one of the most important AZ-104 troubleshooting scenarios because **Function Apps depend entirely on Storage Accounts**.  
If storage access breaks, the Function App effectively dies.

---

## How to think about it

Azure Functions require a storage account for:

1. **Host state**  
2. **Trigger tracking**  
3. **Checkpointing**  
4. **Bindings**  
5. **Logs**  

If the Function App cannot authenticate to or reach the storage account, the runtime refuses to start.

---

## Most common causes

### 1. The storage account key was rotated
Functions authenticate using:

- `AzureWebJobsStorage`  
- `WEBSITE_CONTENTAZUREFILECONNECTIONSTRING`  

If the storage keys were rotated and the Function App still uses the old key → failure.

---

### 2. Storage firewall blocks the Function App
If Storage → Networking is set to:

- “Selected Networks”  
- “Disabled public access”  
- “Private endpoints only”

But the Function App is **not** in the VNet → blocked.

---

### 3. Missing VNet Integration for private endpoints
If storage has a private endpoint but the Function App does **not** have:

- VNet Integration  
- Correct DNS  
- Access to the private DNS zone  

…it still tries to reach the public endpoint → blocked.

---

### 4. Misconfigured App Settings
A typo in:

- `AzureWebJobsStorage`  
- Endpoint suffix  
- Missing `DefaultEndpointsProtocol=https`  

…breaks access completely.

---

### 5. Storage account deleted, renamed, moved, or changed SKU
If someone:

- renames the account  
- deletes it  
- moves regions  
- switches to Premium Block Blob  

…Function App fails instantly.

---

### 6. Function App plan changes
Moving between plans (Consumption → Premium → Dedicated) can change how storage is used.

---

## How to solve it — admin sequence

### Step 1 — Confirm the storage account still exists
Storage Account → Overview.  
Check:

- Name matches  
- Not deleted or moved  
- Not converted to incompatible SKU  

---

### Step 2 — Validate connection string in Function App
Function App → Configuration → Application Settings.

Check:

- `AzureWebJobsStorage` has the **current** storage key  
- No typos  
- Correct key1 or key2  

---

### Step 3 — Check Storage Firewall
Storage → Networking.

Confirm:

- Public access allowed *or*  
- VNet Integration and private endpoint configured  

---

### Step 4 — Verify VNet Integration
Function App → Networking → VNet Integration.

Check:

- Correct subnet  
- DNS configuration  
- No UDR blocking traffic  

---

### Step 5 — Test DNS
From Kudu Console:

nslookup mystorageaccount.blob.core.windows.net


Public access → public IP  
Private endpoint → private IP

---

### Step 6 — Test connectivity
From Kudu:

curl https://mystorageaccount.blob.core.windows.net


- Timeout → network problem  
- 403 → authentication problem  
- 200 → working  

---

### Step 7 — Check Function App logs
Common messages:

- “Host lock lease cannot be acquired”  
- “Failed to initialize triggers”  
- “Cannot access storage account”  

Logs point directly to the failing step.

---

## Why follow these steps?

Function App startup follows a strict pipeline:

1. **Correct connection string?**  
2. **Can it reach the storage account?**  
3. **Is authentication valid?**  
4. **Does DNS resolve the correct endpoint?**  
5. **Is network access permitted?**  
6. **Are private endpoints configured correctly?**

Troubleshooting out of order leads to wasted time:

- Fixing DNS doesn’t help if the key is wrong  
- Fixing the key won’t help if firewall blocks access  
- Fixing firewall won’t help if VNet integration is missing  
- Fixing VNet integration won’t help if storage was deleted  

Following the exact pipeline ensures you fix root causes directly.
