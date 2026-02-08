# 🧂 Password Salting — Defending Stored Credentials

## 🧠 Concept Overview

**Salting** is a security technique used to **protect stored passwords**.

Instead of storing a password directly (which is unsafe), systems:
1. Add a **random value** called a *salt* to the password
2. Hash the combined value
3. Store **only the salt and the hash**, never the password itself

This makes stolen password databases far less useful to attackers.

---

## 🔐 How Salting Works (Conceptual Flow)

1. User creates a password  
2. System generates a **unique random salt**
3. Password + salt are combined
4. The result is **hashed**
5. The hash and salt are stored

When the user logs in, the system:
- Repeats the same process
- Compares the new hash to the stored hash

If they match, authentication succeeds.

---

## 🛡️ Why Salting Is Important

Without salting:
- Identical passwords produce identical hashes
- Attackers can use **rainbow tables** (precomputed hash lists)

With salting:
- The same password produces **different hashes**
- Rainbow tables become useless
- Each account must be attacked **individually**

➡️ Salting **dramatically increases the cost and time** of attacks.

---

## 🔍 Salting vs Hashing

- **Hashing** transforms a password into a fixed-length value
- **Salting** adds randomness *before* hashing

> Salting does **not replace hashing** — it strengthens it.

---

## ☁️ Where You See This in Microsoft Cloud

- Microsoft Entra ID (Azure AD) uses **salted and hashed passwords**
- Passwords are **never stored in plaintext**
- Salting supports:
  - Credential protection
  - Zero Trust principles
  - Defense against credential theft

---

## 🧩 One-Line Summary

**Salting adds a unique random value to a password before hashing to protect stored credentials from reuse and precomputed attacks.**
