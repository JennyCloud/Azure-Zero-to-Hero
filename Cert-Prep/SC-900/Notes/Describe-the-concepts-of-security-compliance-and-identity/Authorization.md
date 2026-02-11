# 🔐 Authorization: Controlling What You Can Do

## 🧠 Concept Overview

**Authorization** answers the question:

> **“What is this authenticated identity allowed to do?”**

Authorization happens **after authentication**.
- Authentication = *Who are you?*
- Authorization = *What can you access or perform?*

In Microsoft cloud services, authorization determines:
- Access to resources
- Allowed actions
- Scope of permissions

---

## 🔁 Authentication vs Authorization (Must-Know Distinction)

- **Authentication**
  - Verifies identity
  - Example: Username + password, MFA
- **Authorization**
  - Grants permissions
  - Example: Read-only access, admin rights

➡️ You cannot be authorized unless you are authenticated first.

---

## 🧩 How Authorization Works in Microsoft Cloud

Authorization is typically implemented using **role-based access control (RBAC)** and **policies**.

### 🧑‍💼 Role-Based Access Control (RBAC)

RBAC assigns permissions through **roles**, rather than directly to users.

A role defines:
- What actions are allowed
- On which resources
- Within what scope

**Example:**
- Reader → View resources
- Contributor → Create and modify resources
- Owner → Full control, including access management

---

### 🎯 Scope of Authorization

Authorization is applied at different scopes:
- Management group
- Subscription
- Resource group
- Individual resource

➡️ Permissions are **inherited downward** from higher scopes.

---

## 🧬 Authorization in SaaS (Microsoft 365)

In SaaS services:
- Authorization is managed using **service roles**
- Examples:
  - Global Administrator
  - Security Administrator
  - Compliance Administrator

These roles define **what users can configure and access** inside the service.

---

## 🛡️ Principle of Least Privilege

Authorization should always follow the **Principle of Least Privilege**:

> Users should have **only the permissions required** to perform their job — nothing more.

Benefits:
- Reduces attack surface
- Limits damage from compromised accounts
- Improves compliance posture

---

## 🧩 One-Line Summary

**Authorization determines what actions an authenticated user or service is allowed to perform on cloud resources, typically enforced through roles and access policies.**
