# 🔄 Azure AD Connect vs Azure AD Domain Services (AAD DS)

## 🧭 Overview

**Azure AD Connect** and **Azure AD Domain Services (AAD DS)** are both part of Microsoft’s hybrid identity stack, but they serve *very different purposes*.  

- **Azure AD Connect** → Synchronizes identities between **on-premises Active Directory** and **Microsoft Entra ID (Azure AD)**.  
- **Azure AD Domain Services** → Provides a **managed domain** inside Azure that supports **legacy Windows authentication** (Kerberos, NTLM, LDAP) for VMs and apps that can’t use modern Entra ID.

---

## ⚙️ Azure AD Connect

**Purpose:** Keep on-premises and cloud directories consistent.

**What it does:**
- Syncs users, groups, and passwords between on-prem AD and Azure AD.
- Supports authentication methods:
  - Password Hash Sync (PHS)
  - Pass-Through Authentication (PTA)
  - Federation (AD FS)
- Enables single sign-on (SSO) for Microsoft 365, Azure Portal, and SaaS apps.
- Handles optional *write-back* of passwords or device info.

**What it does *not* do:**
- Does **not** provide domain join or Group Policy.
- Does **not** host domain controllers in Azure.

**Use when:**
- You have an existing on-prem AD and want cloud SSO for users.

---

## 🏢 Azure AD Domain Services (AAD DS)

**Purpose:** Offer domain controllers as a managed service in Azure.

**What it provides:**
- Domain join for Azure VMs.
- Support for **Kerberos**, **NTLM**, and **LDAP** authentication.
- Group Policy support.
- High availability and backups managed by Microsoft.

**How it works:**
- Synchronizes users from Azure AD (and indirectly from on-prem AD if you use AD Connect).
- Creates a *read-only replica* of your tenant directory inside a VNet.

**Limitations:**
- No schema extensions.
- Flat OU structure.
- No Domain Admin or Enterprise Admin privileges.
- One managed domain per region per tenant.

**Use when:**
- You have **legacy applications** or **lift-and-shift VMs** in Azure that need to join a domain but you don’t want to run your own DCs.

---

## 🔗 How They Work Together

On-prem AD ←→ Azure AD Connect ←→ Azure AD ←→ Azure AD Domain Services

1. **Azure AD Connect** syncs your on-prem identities to Azure AD.  
2. **AAD DS** takes those synced identities and exposes them through a managed domain in Azure.  
3. Azure VMs and legacy apps can domain-join to that managed domain using familiar credentials.

---

## 🧠 When to Use Which

| Scenario | Use **Azure AD Connect** | Use **Azure AD DS** |
|-----------|--------------------------|----------------------|
| Provide cloud SSO for M365 & Azure | ✅ | ❌ |
| Allow Azure VMs to join a domain | ❌ | ✅ |
| Need Kerberos / NTLM / LDAP | ❌ | ✅ |
| Manage own domain controllers | ✅ (on-prem) | ❌ (managed by Microsoft) |
| Apply Group Policy to Azure VMs | ❌ | ✅ |
| Support modern OAuth / SAML apps | ✅ | ❌ |

---

## 🧩 Why You Might Need Both

- **AD Connect** keeps your cloud identities in sync and enables SSO for modern apps.  
- **AAD DS** lets older workloads in Azure (that depend on domain join or LDAP) keep working **without** building your own DCs.  

Example:
> You sync users from on-prem AD to Azure AD using AD Connect.  
> Then, you enable AAD DS so your legacy accounting server in Azure can join a domain and use those same user accounts for LDAP authentication.

---

## 🧮 Analogy

| Service | Analogy |
|----------|----------|
| **Azure AD Connect** | A bridge that copies your phone contacts to the cloud so you have one consistent list. |
| **Azure AD DS** | A classic phone network that still supports old 3G phones while you move to 5G. |

---

## 🧱 Summary

| Feature | **Azure AD Connect** | **Azure AD DS** |
|----------|----------------------|-----------------|
| Primary Role | Identity synchronization | Managed domain controllers |
| Authentication Type | Modern (OAuth, SAML) | Legacy (Kerberos, NTLM) |
| Group Policy | ❌ | ✅ |
| Domain Join for VMs | ❌ | ✅ |
| LDAP Access | ❌ | ✅ |
| Admin Control | Full (on-prem) | Limited |
| Typical User | IT admin managing hybrid identity | Cloud engineer hosting legacy apps |

---

## 📚 Exam Tip

> When a question says **“users sign in to Microsoft 365 with on-prem credentials”** → **Azure AD Connect**  
> When it says **“VMs in Azure need to join a domain or use Group Policy”** → **Azure AD Domain Services**

---

**✅ In short:**  
Use **Azure AD Connect** for **identity sync & modern login**.  
Use **Azure AD Domain Services** for **legacy domain join & LDAP apps** inside Azure.
