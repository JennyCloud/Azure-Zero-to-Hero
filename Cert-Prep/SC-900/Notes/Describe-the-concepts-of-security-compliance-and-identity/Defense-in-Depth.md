# 🛡️ Defense in Depth: Layered Security in Microsoft Cloud

## 🧠 Concept Overview

**Defense in Depth** is a security strategy that uses **multiple layers of protection** to defend systems and data.

Instead of relying on a single control, security is applied at **every level of the environment**.  
If one layer fails, the next layer still provides protection.

The goal is not to make attacks impossible, but to:
- Slow attackers down
- Limit blast radius
- Detect breaches early
- Reduce overall impact

---

## 🧱 The Seven Security Layers

### 🌍 Physical Security
- Datacenters, access controls, surveillance
- **Responsibility:** Microsoft

---

### 🌐 Network Security
- Firewalls, Network Security Groups (NSGs), DDoS protection
- Controls traffic entering and leaving resources

---

### 🖥️ Compute Security
- Operating system hardening
- Endpoint protection
- VM patching

---

### 📦 Application Security
- Secure application design
- Input validation
- Application permissions

---

### 📊 Data Security
- Encryption at rest and in transit
- Data classification
- Backup and recovery

---

### 🆔 Identity & Access
- Authentication and authorization
- Multi-Factor Authentication (MFA)
- Least privilege access

---

### 🔍 Monitoring & Detection
- Logging and alerts
- Microsoft Defender
- Security monitoring and response

---

## 🔐 Key Principle

> **No single security control should be trusted on its own.  
> Every layer assumes the layer below it might fail.**

Defense in Depth assumes **breaches will happen** and designs systems to survive them.

---

## 🎯 Why This Matters

- Explains why **MFA alone is not enough**
- Connects identity, network, data, and monitoring together
