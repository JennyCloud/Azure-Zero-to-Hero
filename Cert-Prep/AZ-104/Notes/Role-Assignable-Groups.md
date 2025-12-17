# Role-Assignable Groups in Microsoft Entra ID

Role-assignable groups are a special type of security group designed for **privileged access**. They can be assigned **directory roles** and **Azure RBAC roles**, which makes them highly sensitive and tightly controlled.

---

## ⭐ What Is a Role-Assignable Group?

A **role-assignable group** is a security group that:

- Can be assigned Microsoft Entra (Azure AD) roles  
- Can be assigned Azure RBAC roles (e.g., Owner, Contributor, Reader)  
- Provides its members with inherited administrative privileges  

Because of this power, Microsoft enforces strict security requirements.

---

## 🔐 Why Role-Assignable Groups Are Special

### ✔ Only Highly Privileged Roles Can Manage Them
Only:

- **Global Administrators**  
- **Privileged Role Administrators**

can add or remove members or modify the group.

User Administrators **cannot** manage these groups.

---

### ✔ Group Owners Do Not Have Full Control
Even if someone is listed as a **group owner**, they **cannot** change membership unless they also hold a high-privilege admin role.

---

### ✔ Must Be a Security Group
Role-assignable groups:

- Cannot be Microsoft 365 groups  
- Must be explicitly created with the `isRoleAssignable` flag  
- Cannot be converted from a normal group later  

---

### ✔ Have Immutable Security Properties
Certain settings, such as group type and role-assignability, cannot be changed after creation.

---

## 🌱 Real-World Use Cases

- Assign RBAC roles to a group instead of many individuals  
- Delegate Entra ID roles like Helpdesk Administrator  
- Manage privileged access using Privileged Identity Management (PIM)

---

## 🚫 What Role-Assignable Groups Cannot Do

- Cannot be **dynamic groups** (to prevent accidental privilege escalation)  
- Cannot be **Microsoft 365 groups**  
- Cannot be managed by User Administrators  
- Cannot be changed into or from a standard group  

---

## 🌼 Clean Mental Model

**Role-assignable groups = privileged containers.  
Only the highest-privilege admins can modify them.**

They exist to enable safe delegation of RBAC and Entra roles while enforcing strict guardrails.

---

## ⭐ Summary

A role-assignable group is a **high-trust, security-sensitive group** that can hold directory roles and Azure RBAC roles.  
Because of this elevated power, only **Global Administrators** and **Privileged Role Administrators** can manage them.  
Group owners and User Administrators cannot modify their membership.
