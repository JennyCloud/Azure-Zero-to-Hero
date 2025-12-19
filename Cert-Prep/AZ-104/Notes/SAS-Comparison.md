# Shared Access Signatures (SAS) Comparison

This document compares the three types of SAS tokens in Azure Storage:  
**User Delegation SAS**, **Service SAS**, and **Account SAS**.

---

## 1. SAS Types — Side-by-Side Comparison

| Feature | **User Delegation SAS** | **Service SAS** | **Account SAS** |
|--------|--------------------------|------------------|------------------|
| **Signed using** | Azure AD user or managed identity | Storage account key | Storage account key |
| **Requires account keys?** | ❌ No | ✅ Yes | ✅ Yes |
| **Works with** | **Blob storage only** | Blob, File, Queue, Table | All services in the storage account |
| **Security level** | ⭐ Highest | Medium | Lowest (widest scope) |
| **Permissions restricted by RBAC?** | **Yes** | No | No |
| **Typical use cases** | Identity-based access, zero-trust, apps using Azure AD | Per-service scoped access | Bulk operations, migrations, admin tasks |
| **Affected by key rotation?** | No | Yes | Yes |
| **Scope** | Container or blob | Specific storage service | Entire storage account |

---

## 2. When to Use Each SAS

### ✔ User Delegation SAS
Use when:
- You want modern, secure, identity-based access
- You want to avoid using account keys
- You only need Blob storage access
- RBAC should enforce maximum allowed permissions

---

### ✔ Service SAS
Use when:
- You need temporary access to a specific service (Blob/File/Queue/Table)
- Your scenario requires Azure Files access (User Delegation SAS does not support Files)
- You are willing to use account keys

---

### ✔ Account SAS
Use when:
- You need broad, multi-service access across the storage account
- You are performing bulk data operations
- You fully trust the recipient of the SAS token

---

## 3. Permissions Logic

### User Delegation SAS
Effective permissions = MIN(RBAC permissions, SAS permissions)

A user cannot generate a SAS with permissions they do not already have through RBAC.

### Service SAS & Account SAS
- Completely ignore RBAC
- Rely only on possession of the storage account key

Whoever has the key can generate SAS tokens with full access.
