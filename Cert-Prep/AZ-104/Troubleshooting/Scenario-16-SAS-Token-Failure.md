# Troubleshooting Scenario #16 — Azure Storage: SAS Token Suddenly Stops Working

## Situation
A third-party app, script, VM, or Function App uses a **SAS token** to access:

- Blob storage  
- File shares  
- Tables  
- Queues  

Everything worked before. Suddenly errors appear:

- “Authentication failed”  
- “Signature not valid in the specified time frame”  
- “This request is not authorized to perform this operation”  
- HTTP 403  
- “Server failed to authenticate the request”  
- “SAS token expired or invalid”

SAS tokens are fragile, time-sensitive, and easily broken — which is why this scenario shows up in AZ-104 exams frequently.

---

## How to think about it

A SAS token is constructed using:

1. **Storage key**  
2. **Permissions**  
3. **Start time & expiry time**  
4. **Resource type** (service, container, object)  
5. **Allowed IPs & protocols**  
6. **Signed version**  

If ANY component is invalid or mismatched → SAS fails immediately.

---

## Most common causes

### 1. SAS token expired
Very common:

- Expiry time passed  
- Clock drift caused early invalidation  
- Start time was set in the future (common mistake)  

Azure rejects SAS tokens with even tiny time offsets.

---

### 2. Storage account keys were regenerated
If key1 or key2 was rotated:

- ALL SAS tokens created from that key stop working instantly.

---

### 3. Wrong SAS type used
Examples:

- Created **account-level SAS**, but app requires **service-level SAS**  
- Created a **blob SAS**, but trying to use it at the **container** level  
- Generated **file SAS**, but using it on blob storage  

Wrong scope = invalid signature.

---

### 4. SAS does not include the required permissions
If SAS includes only read (`r`), but operation requires write (`w`), list (`l`), create (`c`), or delete (`d`), the request fails.

Permission mismatch = 403.

---

### 5. SAS restricted to specific IPs
If SAS includes:

sip=x.x.x.x


Then if:

- App Service outbound IP changes  
- Function App scales to new instance  
- User runs script from new machine  

→ SAS immediately fails.

---

### 6. SAS restricted to HTTPS only
If SAS contains:

`spr=https`

and client uses `http://` → rejected.

---

### 7. Storage firewall changed
If Storage → Networking is updated to:

- “Selected Networks”  
- “Disable public network access”  
- Private endpoints only

Then ANY SAS request from the public internet will fail.

---

### 8. Using ad hoc SAS instead of stored access policy
Ad hoc SAS cannot be extended or revoked.  
If you want long-term control, you must use a **Stored Access Policy**.

---

## How to solve it — admin sequence

### Step 1 — Check SAS validity (time)
Inspect SAS parameters:

- `se=` expiry time  
- `st=` start time  
- `sv=` signed version  
- Clock sync issues  

---

### Step 2 — Verify if storage keys were regenerated
Storage Account → **Access Keys**

If rotated:

- All old SAS tokens become invalid  
- Generate a new SAS

---

### Step 3 — Confirm SAS resource scope
Ensure SAS is for the correct:

- Service (Blob/File/Queue/Table)  
- Level (account, container, object)

---

### Step 4 — Validate permissions
Check that the SAS contains:

- `r` → read  
- `w` → write  
- `c` → create  
- `d` → delete  
- `l` → list  

---

### Step 5 — Check IP restrictions
If `sip=` exists:

- Remove IP restriction  
- Regenerate SAS without IP filtering  

---

### Step 6 — Check Storage firewall
Storage → Networking:

- Is public access blocked?  
- Only selected networks allowed?  
- Private endpoints required?

If yes → SAS from internet will fail.

---

### Step 7 — Check DNS if private endpoint is used
Requests must resolve to:

`<account>.privatelink.core.windows.net`

If resolving to public endpoint → request denied.

---

### Step 8 — Regenerate a new SAS token
Fastest fix:

- Azure Portal  
- Azure CLI  
- SDK  

---

## Why follow these steps?

Azure validates SAS in this order:

1. **Time validity**  
2. **Signature (storage key)**  
3. **Resource match**  
4. **Permission match**  
5. **Network/firewall conditions**  
6. **IP/protocol restrictions**  
7. **DNS resolution**  

Fixing issues out of order wastes time:

- Fixing firewall won’t help if SAS is expired  
- Fixing permissions won’t help if storage key was rotated  
- Fixing IP restriction won’t help if wrong SAS type  
- Fixing DNS won’t help if SAS lacks permission  

Using Azure’s actual SAS validation chain is the fastest path to resolution.
