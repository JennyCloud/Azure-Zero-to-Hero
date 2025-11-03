# 🔐 Azure Role Comparison — User Access Administrator vs User Administrator

## 🧭 Overview
These two roles sound similar but govern **different domains of control** in Azure.  
- **User Access Administrator** manages **resource-level access** (RBAC permissions).  
- **User Administrator** manages **identity-level operations** (users and groups in Microsoft Entra ID).

---

## ⚙️ Role Scopes and Responsibilities

### 🪪 User Administrator (Microsoft Entra ID)
**Scope:** Tenant-wide (Identity layer)

**Responsibilities:**
- Create, update, and delete user accounts and groups  
- Reset passwords for non-admin users  
- Assign Microsoft 365 or Azure licenses  
- Manage group memberships  
- Cannot grant or modify Azure RBAC permissions on resources  

👉 **Focus:** Manages *who exists* in the tenant

---

### 🔐 User Access Administrator (Azure RBAC)
**Scope:** Subscription / Resource Group / Resource level (Resource layer)

**Responsibilities:**
- Grant or revoke **role-based access control (RBAC)** to Azure resources  
- Assign roles like *Reader*, *Contributor*, *Owner*, etc.  
- Does **not** manage user accounts or passwords  

👉 **Focus:** Manages *what users can do* within Azure resources

---

## 🧩 Analogy — The Castle Example
Imagine your Azure environment as a **castle**:

| Role | Analogy |
|:--|:--|
| **User Administrator** | Decides *who lives in the castle* — creates citizens, gives them ID cards, resets their keys |
| **User Access Administrator** | Decides *who can enter which rooms* — grants permissions to open the treasury, the library, or the armory |

---

## 🧱 Comparison Summary

| Feature | **User Administrator (Entra)** | **User Access Administrator (RBAC)** |
|:--|:--|:--|
| **Scope** | Microsoft Entra ID (Tenant-level) | Azure Resource Manager (Resource-level) |
| **Main Function** | Manage users and groups | Manage resource access (RBAC roles) |
| **Can Reset Passwords** | ✅ Yes | ❌ No |
| **Can Assign RBAC Roles** | ❌ No | ✅ Yes |
| **Can Create/Delete Users** | ✅ Yes | ❌ No |
| **Portal Location** | Entra portal → *Identity management* | Azure portal → *Resource management* |

---

## 🧠 Key Insight
These two roles operate in **separate planes of control**:
- **Entra ID (Identity plane)** controls *who a person is*.  
- **Azure RBAC (Resource plane)** controls *what that person can do*.

Understanding this separation helps avoid confusion when troubleshooting access issues or delegating admin rights across teams.
