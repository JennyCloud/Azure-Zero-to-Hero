# 🧭 Active Directory Domain Services (AD DS) — On-Prem Identity Foundation

## 🧠 What is AD DS?

**Active Directory Domain Services (AD DS)** is Microsoft’s **on-premises identity and access management system**.

It allows organizations to:
- Store user and computer identities
- Authenticate users (log in)
- Authorize access to resources
- Centrally manage security policies

AD DS is typically used in **traditional corporate networks** and private datacenters.

---

## 🏗️ Core Components of AD DS

### 👤 Objects
AD DS stores identities as **objects**, such as:
- Users
- Computers
- Groups
- Printers

Each object has attributes (name, password, group membership).

---

### 🌳 Domain
A **domain** is a logical boundary that:
- Shares the same directory database
- Uses the same security policies
- Uses the same authentication rules

Example domain name:  
corp.contoso.com

---

### 🧱 Domain Controller (DC)
A **Domain Controller** is a server that:
- Runs AD DS
- Stores the directory database
- Authenticates users
- Enforces security policies

If the Domain Controller is unavailable, users cannot log in.

---

### 🛡️ Group Policy
**Group Policy** allows administrators to:
- Enforce password policies
- Control device settings
- Lock down user environments

Policies are applied automatically when users sign in.

---

## 🔐 Authentication in AD DS

AD DS primarily uses:
- **Kerberos** (default, secure, ticket-based)
- **NTLM** (legacy, less secure)

Authentication happens **inside the organization’s network**.

---

## ☁️ AD DS vs Azure AD (Entra ID)

| Feature | AD DS | Azure AD (Entra ID) |
|------|------|------|
| Location | On-premises | Cloud |
| Device join | Domain-joined | Azure AD-joined |
| Protocols | Kerberos, NTLM | OAuth 2.0, OpenID Connect |
| Primary use | Internal networks | Cloud & SaaS apps |

AD DS is **not cloud-native**.

---

## 🔁 Hybrid Identity

Many organizations use **both**:
- AD DS (on-prem)
- Azure AD / Microsoft Entra ID (cloud)

They connect them using **Azure AD Connect**, enabling:
- Same username and password
- Single Sign-On (SSO)
- Hybrid identity

---

## 🧩 One-Line Summary

**Active Directory Domain Services is an on-premises directory service that manages identities, authentication, and access to resources within an organization’s network.**
