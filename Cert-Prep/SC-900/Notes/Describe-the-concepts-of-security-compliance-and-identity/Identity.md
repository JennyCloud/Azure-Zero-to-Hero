# 🪪 Digital Identity in Microsoft Security Fundamentals

## 🧠 What Is Identity?

In Microsoft security, an **identity** is a **digital representation of something that can be authenticated and authorized**.

An identity answers two fundamental questions:
- **Who or what are you?** (Authentication)
- **What are you allowed to do?** (Authorization)

Identities are not only people.  
They can represent **users, devices, applications, or services**.

---

## 🧑‍💼 Types of Identities

### 👤 User Identities
Represent human users.
- Employees
- Administrators
- External users (guests)

Used to sign in to services like Microsoft 365 and Azure.

---

### 💻 Device Identities
Represent physical or virtual devices.
- Laptops
- Phones
- Virtual machines

Used to assess **device trust** (managed, compliant, healthy).

---

### 🤖 Workload / Application Identities
Represent non-human actors.
- Applications
- Services
- Automation scripts

Common examples:
- Service principals
- Managed identities

---

## 🔐 Authentication vs Authorization

### 🔑 Authentication
Proves the identity is legitimate.
- Passwords
- Biometrics
- Certificates
- Multi-Factor Authentication (MFA)

**Authentication answers:**  
> “Are you really who you claim to be?”

---

### 🧾 Authorization
Determines access after authentication.
- Roles
- Permissions
- Access policies

**Authorization answers:**  
> “What are you allowed to do?”

---

## 🧭 Identity Provider (IdP)

An **Identity Provider** is a service that:
- Stores identities
- Authenticates users
- Issues security tokens

In Microsoft cloud, the primary IdP is:
- **Microsoft Entra ID** (formerly Azure Active Directory)

---

## 🧠 Identity as the New Security Perimeter

Traditional security relied on network boundaries.
Modern security assumes:
- Users work remotely
- Devices are everywhere
- Networks are untrusted

As a result:
> **Identity has replaced the network as the primary security boundary**

This idea underpins **Zero Trust** architecture.

---

## 🎯 Why Identity Matters

Identity is central to:
- Zero Trust
- Conditional Access
- Least Privilege
- Cloud security

Most real-world breaches involve:
- Stolen credentials
- Excessive permissions
- Weak authentication

---

## 🧩 One-Line Summary

**Identity is the foundation of modern security, representing users, devices, and applications, and controlling access through authentication and authorization.**
