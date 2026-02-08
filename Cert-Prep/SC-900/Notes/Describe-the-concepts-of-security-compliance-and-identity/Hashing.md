# 🔐 Hashing — One-Way Integrity Protection

## 🧠 Concept Overview

**Hashing** is a cryptographic process that converts input data (such as a password or file) into a **fixed-length string of characters**, called a **hash**.

Hashing is **one-way**:
- You can generate a hash from data
- You **cannot** reverse the hash to recover the original data

This makes hashing ideal for **integrity verification** and **password storage**.

---

## ⚙️ How Hashing Works (Conceptually)

1. Input data is passed into a **hash function**
2. The function produces a **unique hash value**
3. The same input always produces the same hash
4. A small change in input creates a **completely different hash**

Example:
Password123 → 8c6976e5b5410415bde908bd4dee15df


---

## 🔑 Key Properties of Hashing

- **One-way**  
  Hashes cannot be reversed

- **Deterministic**  
  Same input = same output

- **Fixed length**  
  Output length does not depend on input size

- **Collision-resistant**  
  Extremely hard for two different inputs to produce the same hash

---

## 🛡️ Hashing in Microsoft Security (SC-900 Context)

### Password Protection
- Microsoft **does not store passwords in plain text**
- Passwords are **hashed** before storage
- During login, the entered password is hashed and compared

### Integrity Verification
- Hashing is used to confirm that:
  - Files were not altered
  - Data remains intact during transmission

---

## 🧂 Hashing vs Encryption

| Feature | Hashing | Encryption |
|------|--------|-----------|
| Reversible | ❌ No | ✅ Yes |
| Purpose | Integrity | Confidentiality |
| Key required | ❌ No | ✅ Yes |
| Password storage | ✅ Yes | ❌ No |

---

## 🎯 Why Hashing Matters

- Prevents password exposure
- Protects against credential theft
- Supports Zero Trust identity principles

---

## 🧩 One-Line Summary

**Hashing is a one-way cryptographic process used to protect passwords and verify data integrity by converting data into a fixed-length, non-reversible value.**
