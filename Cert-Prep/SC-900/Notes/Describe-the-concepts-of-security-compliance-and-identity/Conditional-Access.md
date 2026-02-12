# 🛡️ Conditional Access: Intelligent Access Control in Microsoft Entra

## 🧠 Concept Overview

**Conditional Access** is a policy-based access control system in **Microsoft Entra ID** (formerly Azure AD).

It evaluates **signals** about a user and decides whether to:

- Grant access
- Grant access with conditions (e.g., require MFA)
- Block access

It enforces access decisions using **if–then logic**:

> If certain conditions are met → Then apply specific access controls.

---

## 🧩 How Conditional Access Works

Conditional Access evaluates multiple signals:

- 👤 User or group membership
- 📱 Device state (compliant, hybrid joined, etc.)
- 🌍 Location (trusted network, risky country)
- 💻 Application being accessed
- ⚠️ Sign-in risk (from Identity Protection)

Based on those signals, it applies **access controls**, such as:

- Require Multi-Factor Authentication (MFA)
- Require compliant device
- Require password change
- Block access

---

## 🏗️ Policy Structure

A Conditional Access policy contains:

### 1️⃣ Assignments (The "If" Part)
Defines who and what the policy applies to:
- Users or groups
- Cloud apps
- Conditions (location, device platform, risk level)

### 2️⃣ Access Controls (The "Then" Part)
Defines what must happen:
- Grant with MFA
- Grant with device compliance
- Block access

---

## 🔐 Example Policy

**Scenario:**  
A user tries to access Microsoft 365 from outside Canada.

**Policy:**
- If user is outside trusted location  
- Then require MFA

Result:
- Inside trusted network → normal sign-in
- Outside network → MFA required

This is adaptive security in action.

---

## 🧩 One-Line Summary

**Conditional Access is a Microsoft Entra policy engine that evaluates sign-in conditions and automatically enforces access requirements such as MFA or device compliance.**
