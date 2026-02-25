# 🔐 Data Security Fundamentals in Microsoft SC-900

## 🧠 What is Data Security?

Data security is the practice of protecting data from:
- Unauthorized access
- Accidental exposure
- Data loss
- Misuse or exfiltration

In Microsoft cloud environments, data security focuses on:
- Protecting data at rest
- Protecting data in transit
- Protecting data in use
- Controlling access to data
- Monitoring and preventing data leakage

---

## 🏗️ Core Pillars of Data Security in Microsoft Cloud

### 1️⃣ Encryption

Encryption converts readable data into unreadable form.

- **Data at rest** → Encrypted using technologies like:
  - Azure Storage encryption
  - BitLocker
  - Transparent Data Encryption (TDE)

- **Data in transit** → Protected using:
  - TLS (Transport Layer Security)
  - HTTPS

Key idea:
Even if someone steals the storage, they can’t read the data without the key.

---

### 2️⃣ Access Control (Identity-Based Security)

Data is protected by controlling who can access it.

- Azure RBAC (Role-Based Access Control)
- Microsoft Entra ID authentication
- Multi-Factor Authentication (MFA)
- Conditional Access policies

Principle:
> The most secure data is data no unauthorized user can reach.

---

### 3️⃣ Data Loss Prevention (DLP)

DLP prevents sensitive information from being:
- Shared externally
- Sent via email accidentally
- Uploaded to unauthorized locations

Examples:
- Blocking credit card numbers in emails
- Preventing confidential files from being shared publicly

---

### 4️⃣ Information Protection & Sensitivity Labels

Data can be classified and labeled:

- Public
- Internal
- Confidential
- Highly Confidential

Labels can:
- Encrypt documents
- Restrict copying/printing
- Expire access
- Track usage

Protection travels with the file — even outside the organization.

---

### 5️⃣ Monitoring and Threat Detection

Microsoft tools monitor unusual data activity:

- Detect mass downloads
- Detect suspicious sharing
- Alert on insider risks

Security is not just prevention — it’s detection and response.

---

## 🔁 Data States You Must Remember

| Data State      | Protection Method |
|-----------------|-------------------|
| At Rest         | Encryption        |
| In Transit      | TLS / HTTPS       |
| In Use          | Access control + monitoring |

---

## 🧩 One-Line Summary

Data security in SC-900 focuses on encrypting data, controlling access through identity, preventing data loss, classifying sensitive information, and monitoring for suspicious activity.
