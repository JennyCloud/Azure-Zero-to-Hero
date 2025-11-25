# Why Azure Allows Only Five Stored Access Policies Per Container

Azure’s “five stored access policies per container” limit isn’t arbitrary. It’s a design choice rooted in how Azure Storage preserves performance, consistency, and scalability at massive global scale.

## The Core Idea  
Stored access policies live **inside the container’s ACL (access control list) metadata**. Every time a SAS token references a stored access policy, Azure reads and resolves that metadata. Keeping the ACL small prevents latency spikes and replication issues. Five policies is the safe, predictable upper bound.

## Digging Deeper

### 1. Metadata Size & Replication Efficiency  
A stored access policy contains:  
- start time  
- expiry time  
- permissions  

These policies are part of the container’s metadata. That metadata must be:  
- read extremely quickly  
- serialized efficiently  
- replicated across multiple storage nodes and regions  
- kept consistent under enormous traffic

Larger ACL metadata → slower replication → higher risk of conflicts.  
The five-policy limit ensures the ACL stays tiny, which keeps Azure Storage fast and deterministic.

### 2. Preventing ACL Misuse  
If Azure allowed dozens of stored access policies, developers might treat them like an IAM (identity and access management) system.  
But SAS policies are intended for **coarse-grained, long-lived access patterns**, such as:  
- a daily backup job  
- a SAS for a partner integration  
- a temporary migration token

For actual fine-grained access control, Azure wants you to use:  
- **RBAC (Role-Based Access Control)**  
- **Azure AD / Microsoft Entra ID**

The five-policy ceiling subtly guides users toward the correct access model.

### 3. Consistency During Revocation and Failover  
When you revoke a SAS tied to a stored access policy, Azure must:  
- update the policy  
- replicate the change  
- invalidate caches  
- ensure consistency globally

A small, bounded number of policies makes revocation and failover behavior simple and reliable across regions.

## What This Means for You  
A container should only have **a few distinct access “patterns”**.  
If you need more than five, you’re likely trying to use SAS policies to solve an IAM problem.

Use stored access policies for:  
- rotating SAS permissions  
- managing expiry  
- revocation  

Use RBAC + identity-based access for:  
- large numbers of users  
- complex permissions  
- scalable access management

## A Fun Bit of History  
SAS and stored access policies date back to early Azure Storage — a simpler era with fewer identity options. The five-policy limit is a historical artifact that still makes sense for today’s hyper-distributed storage architecture.

