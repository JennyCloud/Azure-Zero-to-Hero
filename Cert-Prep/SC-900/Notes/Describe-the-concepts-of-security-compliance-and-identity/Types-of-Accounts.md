# 👤 Types of Accounts in Microsoft Entra ID

## 🧠 Concept Overview

In Microsoft cloud environments, **accounts represent identities**.  
Each account type exists for a **different purpose**, and understanding the difference is critical for **security and access control**.

In **SC-900**, account types are usually discussed in the context of **Microsoft Entra ID**.

---

## 🧑 User Accounts

### 🔹 Cloud User Account
**What it is:**  
An identity created **directly in Microsoft Entra ID**.

**Used for:**
- Signing in to Microsoft 365
- Accessing Azure resources
- Cloud-only organizations

**Key points:**
- Stored entirely in the cloud
- Can use MFA and Conditional Access
- Most common account type in modern environments

---

### 🔹 Synced User Account
**What it is:**  
An identity synced from **on-premises Active Directory** to Entra ID using **Entra Connect**.

**Used for:**
- Hybrid environments
- Single identity across on-prem and cloud

**Key points:**
- Authentication can occur on-prem or in the cloud
- Passwords may be synced or federated
- Common in enterprises migrating to the cloud

---

### 🔹 Guest User Account
**What it is:**  
An external user invited into your tenant using **Azure AD B2B (Business-to-Business)**.

**Used for:**
- Partners
- Contractors
- Vendors

**Key points:**
- Uses their own external identity
- Limited access by default
- Can be controlled with Conditional Access

---

## 🤖 Non-Human Accounts

### 🔹 Service Account
**What it is:**  
An account used by **applications or services**, not people.

**Used for:**
- Background processes
- Automation
- Legacy applications

**Key points:**
- Often over-permissioned (security risk)
- Being replaced by managed identities
- Requires careful lifecycle management

---

### 🔹 Managed Identity
**What it is:**  
A Microsoft-managed identity for Azure resources.

**Used for:**
- Secure app-to-resource authentication
- Accessing Azure services without credentials

**Key points:**
- No passwords or secrets to manage
- Automatically rotated by Microsoft
- Recommended over service accounts

---

## 🧪 Special-Purpose Accounts

### 🔹 Administrator Account
**What it is:**  
A user account assigned **privileged roles** (e.g. Global Administrator).

**Used for:**
- Tenant-wide management
- Security and identity configuration

**Key points:**
- Should be protected with MFA
- Least privilege is critical
- High-value attack target

---

## 🎯 Why This Matters

- Identity is the **new security perimeter**
- Forms the foundation for:
  - Zero Trust
  - Conditional Access
  - Privileged Identity Management (PIM)
