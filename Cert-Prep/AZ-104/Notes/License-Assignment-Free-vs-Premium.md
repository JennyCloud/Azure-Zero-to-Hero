# 🧾 License Assignment — Free vs Premium Tenants

## 🧠 Explanation

In Microsoft Entra ID, license assignment behavior depends on the **edition** of the tenant.

The **Free edition** only allows licenses to be assigned directly to **individual users**.  
Group-based license assignment (to security groups or Microsoft 365 groups) requires a **Premium license** — specifically **Entra ID P1** or **P2**.

---

## ⚙️ License Assignment Behavior

| Identity Type | Assign License (Free Tenant) | Notes |
|----------------|------------------------------|-------|
| **User account** | ✅ Yes | Licenses (Microsoft 365, Power BI, Fabric, etc.) can always be assigned directly to users. |
| **Security group** | ❌ No | Requires **Entra ID P1/P2** for group-based licensing. |
| **Microsoft 365 group** | ❌ No | Collaboration groups cannot be used for license assignment. |

---

## 🧩 Feature Comparison

| Feature | Entra ID Free | Entra ID P1 | Entra ID P2 |
|----------|----------------|--------------|--------------|
| Group-based licensing | ❌ | ✅ | ✅ |
| Conditional Access | ❌ | ✅ | ✅ |
| Dynamic groups | ❌ | ✅ | ✅ |
| Privileged Identity Management (PIM) | ❌ | ❌ | ✅ |

---

## ✅ Key Takeaway

> In a **Microsoft Entra ID Free** tenant, you can assign licenses **only to individual users**.  
> Group-based licensing and automation require a **Premium (P1 or P2)** plan.

---

**Example use case:**  
A Fabric license can be assigned to **User1**, but not to **Group1** (security group) or **Group2** (Microsoft 365 group), because the tenant runs on **Microsoft Entra ID Free**.
