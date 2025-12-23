# Azure Migrate vs Azure Site Recovery (ASR)

## Overview

**Azure Migrate** and **Azure Site Recovery (ASR)** are often mentioned together, but they serve different roles in the migration journey.

- **Azure Migrate** is the **planning and orchestration hub**
- **Azure Site Recovery (ASR)** is the **replication and failover engine**

They work together, but they are not the same service.

---

## Azure Migrate

**Purpose:**  
Discovery, assessment, and migration planning.

**Key Capabilities:**
- Discover on-premises servers (VMware, Hyper-V, physical)
- Assess Azure readiness and compatibility
- Estimate Azure costs and right-size VMs
- Dependency visualization
- Central dashboard to manage migration tools

**Important:**  
Azure Migrate does **not** replicate data itself.  
It uses tools like **ASR** under the hood to perform migrations.

---

## Azure Site Recovery (ASR)

**Purpose:**  
Replication, failover, and migration execution.

**Key Capabilities:**
- Continuous disk replication to Azure
- Test failover without downtime
- Planned failover (migration cutover)
- Disaster recovery after migration if needed

**Originally designed for DR**, but fully supported for **VM migration to Azure**.

---

## Relationship Between Azure Migrate and ASR

- Azure Migrate = **orchestrator**
- ASR = **replication mechanism**

Azure Migrate often **invokes ASR** to migrate:
- VMware vSphere VMs
- Physical servers

You can use ASR **directly** without Azure Migrate, but you lose:
- Assessment
- Cost estimation
- Centralized planning

---

## Simple Analogy

> Azure Migrate draws the map and plans the move.  
> Azure Site Recovery drives the truck and moves the machines.
