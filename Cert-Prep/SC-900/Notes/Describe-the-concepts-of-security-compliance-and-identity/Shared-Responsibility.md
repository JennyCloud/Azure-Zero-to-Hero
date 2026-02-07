# ☁️ Shared Responsibility Model in Microsoft Cloud

## 🧠 Concept Overview

The **Shared Responsibility Model** explains **who is responsible for what** when using cloud services.

In the cloud, **security and compliance are not owned by a single party**.  
Instead, responsibilities are **shared between Microsoft (the cloud provider)** and **the customer (you)**.

The exact split depends on the **cloud service model**:
- IaaS (Infrastructure as a Service)
- PaaS (Platform as a Service)
- SaaS (Software as a Service)

---

## 🏗️ Responsibility Breakdown by Service Model

### 🧱 Infrastructure as a Service (IaaS)
**Example:** Azure Virtual Machines

- **Microsoft is responsible for:**
  - Physical datacenters
  - Physical network
  - Physical servers
  - Host operating system

- **Customer is responsible for:**
  - Guest OS (patching, hardening)
  - Applications
  - Data
  - Identity and access management
  - Network controls (NSGs, firewalls)

➡️ **Customer has the most responsibility** in IaaS.

---

### 🧰 Platform as a Service (PaaS)
**Example:** Azure App Service, Azure SQL Database

- **Microsoft is responsible for:**
  - Physical infrastructure
  - Host OS
  - Platform runtime
  - Patching of the platform

- **Customer is responsible for:**
  - Application code
  - Data
  - Identity and access
  - Configuration and permissions

➡️ Responsibility shifts **up the stack** to Microsoft.

---

### ☁️ Software as a Service (SaaS)
**Example:** Microsoft 365, Dynamics 365

- **Microsoft is responsible for:**
  - Infrastructure
  - Platform
  - Application
  - Availability and patching

- **Customer is responsible for:**
  - User access
  - Identity (accounts, MFA)
  - Data governance
  - Compliance configurations

➡️ **Microsoft handles almost everything**, but **identity and data ownership always stay with the customer**.

---

## 🔐 Key Rule

> **Microsoft is always responsible for the security *of* the cloud.  
> Customers are always responsible for security *in* the cloud.**

This rule **never changes**, regardless of service model.
