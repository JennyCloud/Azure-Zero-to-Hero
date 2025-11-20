# Secure Access to Azure Storage
## Identity-based Access vs SAS

### Identity-based Access (best for modern apps)
Identity-based access uses Microsoft Entra ID and RBAC (role-based access control). Your app authenticates with its identity, and Azure checks its roles.

The perks:  
- Zero tokens floating around  
- No key rotation needed  
- You can revoke permissions by removing the role  
- Logs show exactly who did what  

This is the cloud-native way. But legacy systems, scripts, and IoT devices often can’t use Entra ID.

### SAS (Shared Access Signature)
SAS is like giving someone a signed permission slip with a time limit. A SAS grants just enough access for a limited time. But SAS tokens are bearer tokens — whoever holds the token can use it.

That’s where stored access policies come in.

---

## Account SAS vs Service SAS

### Account SAS
- Scope: entire storage account  
- Covers blobs, files, queues, tables  
- Wide blast radius if compromised  
- Harder to revoke (must rotate keys)  

Use only for controlled automation.

### Service SAS
- Scope: one container, share, queue, or table  
- Lower risk  
- Tied to stored access policies  
- Easiest to revoke and rotate  

### User Delegation SAS
- Uses Entra ID instead of account keys  
- Least risky  
- Requires newer app infrastructure

---

## SAS + Stored Access Policy = Revocation Superpower
A SAS without a stored access policy is like handing someone a printed ticket. If it leaks, you wait for it to expire.

A SAS with a stored access policy is like handing them a card that checks back with the central database every time.

If trouble strikes:  
- Delete the policy  
- Modify permissions  
- Change expiry time  
All SAS linked to that policy instantly change.

Stored access policies give you instant global control.

---

## Relationship to Key Rotation
Rotating storage account keys is a messy operation:
- Every SAS generated from account keys becomes invalid  
- Every app using a key must update its connection string  
- You need orchestration to avoid downtime  

Stored access policies reduce this pain because:
- You can revoke SAS without touching keys  
- Only SAS tied to the deleted policy are affected  
- You never break unrelated apps  

They act as a mini authorization layer inside your storage account.

---

## Hardening SAS: The Fun Extras

You can make a SAS token extremely specific. Each limit is like tightening a bolt.

- Force HTTPS  
- IP restrictions  
- Short lifetimes  
- Limited permissions  

Azure loves least privilege.
