# 🔗 Identity Federation in Microsoft Entra ID

## 🧠 Concept Overview

**Federation** is an identity model that allows users to **authenticate using credentials from a trusted external identity provider**.

Instead of creating and managing separate accounts in every system, **trust is established between identity systems**, enabling users to sign in **without re-entering credentials**.

In Microsoft cloud services, federation commonly involves:
- **Microsoft Entra ID (Azure AD)**
- An **external Identity Provider (IdP)** such as:
  - Active Directory Federation Services (AD FS)
  - Another Entra ID tenant
  - A third-party IdP

---

## 🔐 How Federation Works (High Level)

1. A user attempts to sign in to a Microsoft cloud service
2. Microsoft Entra ID detects the user is **federated**
3. Authentication is **redirected to the trusted IdP**
4. The IdP verifies the user’s credentials
5. A security token is issued and trusted by Entra ID
6. Access is granted without storing the user’s password in Entra ID

➡️ **Authentication happens elsewhere, but authorization happens in Entra ID**

---

## 🧩 Federation vs Cloud Authentication

### ☁️ Cloud Authentication
- Credentials are stored in Microsoft Entra ID
- Microsoft handles authentication directly
- Examples:
  - Password Hash Synchronization (PHS)
  - Pass-through Authentication (PTA)

### 🔗 Federated Authentication
- Credentials remain with the external IdP
- Microsoft Entra ID trusts the external system
- Example:
  - On-premises AD with AD FS

➡️ Federation is about **trust, not duplication**

---

## 🏢 Common Federation Scenarios

- Hybrid environments with on-premises Active Directory
- Organizations with strict password or compliance requirements
- Business-to-business (B2B) collaboration
- Cross-organization access without account duplication

---

## 🎯 Why Federation Matters

- Explains **how authentication can occur outside Microsoft**
- Helps distinguish **federation vs synchronization**
- Foundational for understanding:
  - Single Sign-On (SSO)
  - Hybrid identity
  - External identities

---

## 🧠 Key Insight

> **Federation means Microsoft Entra ID trusts another identity provider to authenticate users.**

Passwords are **not** stored in Entra ID in a federated setup.

---

## 🧩 One-Line Summary

**Federation allows users to authenticate using credentials from a trusted external identity provider while Microsoft Entra ID handles access and authorization.**
