# 🔒 Azure RBAC — Virtual Machine Contributor vs Disk Snapshot Contributor

## 🎯 Concept Overview
In Azure, **roles** define what actions a user can perform on resources. Each role grants a set of **permissions** (also called *actions*), which are API-level rights that control what a user can do.

---

## 🧠 Virtual Machine Contributor
**Purpose:** Manage virtual machines and their attached resources.

**Key Permissions:**
- Create, start, stop, and delete virtual machines.
- Attach or detach existing disks.
- Configure VM settings and extensions.

**Limitations:**
- ❌ Cannot create, delete, or manage **disk snapshots**.
- ❌ Cannot delegate permissions or assign roles.

This role is perfect for operations engineers or administrators who manage compute resources but shouldn’t alter underlying storage snapshots.

---

## 💾 Disk Snapshot Contributor
**Purpose:** Manage **disk snapshot** resources used for backup and restore operations.

**Key Permissions:**
- Create, read, and delete snapshots (`Microsoft.Compute/snapshots/*`).
- View and manage metadata of snapshot resources.

**Limitations:**
- ❌ Cannot start, stop, or modify virtual machines.
- ❌ Cannot attach or detach disks.

This role fits users responsible for **backup**, **disaster recovery**, or **image management**, without giving them full VM control.

---

## ⚙️ Real-World Example
A DevOps engineer performing patch management might:
1. Take a **snapshot** before applying updates → needs **Disk Snapshot Contributor**.
2. Restart or resize the **VM** after updates → needs **Virtual Machine Contributor**.

By assigning both roles, the engineer can complete maintenance safely without unnecessary access to other resources.
