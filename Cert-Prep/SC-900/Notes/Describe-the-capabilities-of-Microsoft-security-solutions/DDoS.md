# 🌊 Distributed Denial-of-Service (DDoS) Attacks in Microsoft Security

## 🧠 Concept Overview

A **Distributed Denial-of-Service (DDoS) attack** occurs when multiple systems flood a target (such as a website or cloud service) with massive amounts of traffic, overwhelming its resources and making it unavailable to legitimate users.

The goal of a DDoS attack is **availability disruption**, not data theft.

In security terms, it targets the **"Availability"** component of the CIA triad:
- Confidentiality
- Integrity
- Availability

---

## 🔥 How a DDoS Attack Works

1. An attacker controls many compromised devices (a botnet).
2. These devices send large volumes of traffic to a target.
3. The target's:
   - Bandwidth
   - CPU
   - Memory
   - Network resources  
   become overloaded.
4. Legitimate users cannot access the service.

Think of it like 50,000 fake customers rushing into a store at once. Real customers can’t get in.

---

## ☁️ DDoS in Microsoft Azure

Microsoft protects cloud workloads using:

### 🛡️ Azure DDoS Protection

- **Azure DDoS Protection Basic**
  - Automatically enabled for all Azure customers
  - Protects against common network-layer attacks

- **Azure DDoS Protection Standard**
  - Enhanced detection and mitigation
  - Adaptive tuning per application
  - Attack analytics and reporting
  - Cost protection during scale-out events

---

## 📍 What Layer Is Targeted?

DDoS attacks typically target:

- **Layer 3 (Network layer)** – ICMP floods
- **Layer 4 (Transport layer)** – TCP/UDP floods
- Sometimes **Layer 7 (Application layer)** – HTTP floods

SC-900 mainly focuses on **network-level protection** via Azure DDoS Protection.

---

## 🎯 Why This Matters

- **Microsoft protects the infrastructure**
- **Customers configure and enable advanced protections (Standard tier)**

---

## 🧩 One-Line Summary

**A DDoS attack overwhelms a service with massive distributed traffic to make it unavailable, and Azure DDoS Protection mitigates these attacks at the network layer.**
