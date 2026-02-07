# 🔐 Zero Trust Security Model in Microsoft Cloud

## 🧠 Concept Overview

**Zero Trust** is a modern security model based on a simple assumption:

> **Never trust, always verify.**

In a Zero Trust architecture, **no user, device, or network location is trusted by default**, even if it is inside the corporate network.

Every access request must be:
- Explicitly verified
- Continuously evaluated
- Limited to the minimum required permissions

---

## 🧱 The Three Core Principles of Zero Trust

### 1️⃣ Verify Explicitly
Access decisions are based on **multiple signals**, such as:
- User identity
- Device health and compliance
- Location
- Risk level
- Application sensitivity

➡️ Authentication and authorization are **dynamic**, not one-time events.

---

### 2️⃣ Use Least Privilege Access
Users and services are granted **only the permissions they need**, for **only as long as needed**.

Examples:
- Role-based access control (RBAC)
- Just-In-Time (JIT) access
- Privileged Identity Management (PIM)

➡️ Reduces blast radius if an account is compromised.

---

### 3️⃣ Assume Breach
Zero Trust assumes attackers are **already inside** the environment.

Security controls focus on:
- Limiting lateral movement
- Segmenting access
- Monitoring continuously
- Detecting and responding quickly

➡️ The goal is **containment, not blind prevention**.

---

## ☁️ Zero Trust in Microsoft Cloud (High Level)

Microsoft implements Zero Trust across **six foundational pillars**:
- Identity
- Devices
- Applications
- Data
- Infrastructure
- Network

For **SC-900**, the most important pillar is **Identity**, because:
- Identity is the new security perimeter
- Most attacks start with credential compromise

---

## 🔐 Zero Trust and Identity (SC-900 Focus)

Key identity-related concepts that support Zero Trust:
- Multi-Factor Authentication (MFA)
- Conditional Access
- Risk-based authentication
- Continuous access evaluation

➡️ Identity controls decide **who can access what, under which conditions**.
