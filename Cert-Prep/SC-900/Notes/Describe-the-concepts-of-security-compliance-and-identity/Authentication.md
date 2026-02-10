# 🔐 Authentication: Proving Who You Are

## 🧠 Concept Overview

**Authentication** is the process of **verifying the identity of a user, device, or service**.

It answers exactly one question:

> **“Who are you?”**

Authentication happens **before** authorization and is a **foundational control** in all security systems.

If authentication fails, **nothing else matters**.

---

## 🔑 Common Authentication Factors

Authentication is based on one or more **factors**:

- **Something you know**  
  Password, PIN

- **Something you have**  
  Phone, hardware token, smart card

- **Something you are**  
  Fingerprint, face, iris (biometrics)

Using **two or more factors** is called **Multi-Factor Authentication (MFA)**.

---

## 🔐 Authentication vs Authorization

- **Authentication:** Who are you?
- **Authorization:** What are you allowed to do?

You must **authenticate first** before authorization can occur.

---

## ☁️ Authentication in Microsoft Cloud (SC-900 Context)

In Microsoft cloud services, authentication is commonly handled by:

- **Microsoft Entra ID (formerly Azure AD)**
- **On-premises Active Directory (AD)**
- **Hybrid identity setups**

Authentication applies to:
- Users
- Devices
- Applications
- Services

---

## 🧰 Common Authentication Methods

- Username and password
- Multi-Factor Authentication (MFA)
- Passwordless authentication
  - Windows Hello for Business
  - FIDO2 security keys
- Certificate-based authentication
- Federated authentication (SSO with other identity providers)

---

## 🔄 Authentication Flow (Simplified)

1. User attempts to sign in
2. Identity provider verifies credentials
3. Authentication factors are validated
4. A security token is issued
5. Access request proceeds to authorization

---

## 🛡️ Why Authentication Matters for Security

Weak authentication leads to:
- Account compromise
- Credential theft
- Unauthorized access

Strong authentication enables:
- Zero Trust
- Conditional Access
- Identity-based security
