# 🔐 CIA Triad — Core Security Principles

## 🧠 Concept Overview

The **CIA Triad** defines the **three fundamental goals of information security**:

- **Confidentiality**
- **Integrity**
- **Availability**

Every security control, policy, or product in Microsoft’s security ecosystem exists to protect **one or more** of these three principles.

---

## 🔒 Confidentiality

**Confidentiality** ensures that **only authorized users or systems can access data**.

The goal is to prevent **unauthorized disclosure** of information.

### Microsoft Examples
- Identity and Access Management (Microsoft Entra ID)
- Multi-Factor Authentication (MFA)
- Conditional Access
- Encryption (at rest and in transit)
- Role-Based Access Control (RBAC)

➡️ If someone **shouldn’t see the data**, confidentiality has failed.

---

## 🧾 Integrity

**Integrity** ensures that **data remains accurate, complete, and unaltered** unless changed by an authorized entity.

The goal is to prevent **unauthorized modification or tampering**.

### Microsoft Examples
- File hashes and checksums
- Digital signatures
- Azure Monitor and activity logs
- Microsoft Defender for Cloud alerts
- Version control and backups

➡️ If data is **changed without permission**, integrity has failed.

---

## ⚙️ Availability

**Availability** ensures that **data and services are accessible when needed** by authorized users.

The goal is to prevent **disruption or downtime**.

### Microsoft Examples
- Azure high availability and redundancy
- Service Level Agreements (SLAs)
- Load balancing
- Backup and disaster recovery
- DDoS Protection

➡️ If users **can’t access the service**, availability has failed.

---

## 🎯 Why the CIA Triad Matters

- Forms the **foundation of all security thinking**
- Used to explain **security incidents and controls**
- Helps classify **threats and mitigations**

---

## 🧩 One-Line Summary

**The CIA Triad describes the three core security goals: protecting data from unauthorized access (Confidentiality), unauthorized change (Integrity), and unplanned downtime (Availability).**
