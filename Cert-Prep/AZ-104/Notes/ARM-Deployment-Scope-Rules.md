# Azure ARM Deployment Scope Rules — Understanding Valid & Invalid Scope Combinations

Azure’s deployment scopes behave like nested layers. Each scope can only deploy to **itself** or **one level below**.


## Management Group Scope + Subscription Scope = Valid

A deployment at the **management group** level *can* deploy into its immediate children — the **subscriptions** underneath it.

### Allowed examples:
- Policy definitions
- Policy assignments (targeting subscriptions)
- Role definitions
- Role assignments (targeting subscriptions)
- Moving or organizing subscriptions

Azure allows this because:

**Management group → Subscription**  
is a **single-level downward hop**, which is valid.

---

## Management Group Scope + Resource Group Scope = Not Valid

A management group deployment **cannot** deploy resources directly into a **resource group** because that requires skipping over an entire layer:

**Management group → Subscription → Resource group**

Azure forbids scope skips.

### Not allowed:
- Creating a VM from MG scope  
- Creating a VNet from MG scope  
- Creating storage accounts, NICs, key vaults, etc.

MG deployments can only work with **management-group–level** or **subscription-level** objects.

---

## Summary: Valid vs Invalid Scope Hops

### ✔ Valid downward hops:
- Tenant → Management group  
- Management group → Subscription  
- Subscription → Resource group  

### ✖ Invalid hops:
- Management group → Resource group (skips subscription)  
- Tenant → Subscription (skips MG, unless no MG exists)  
- Tenant → Resource group (skips multiple layers)  

### ✖ Upward hops are never allowed:
- RG → Subscription/MG  
- Subscription → MG  
- Subscription → Tenant  
- RG → Tenant  

Azure never allows upward scope deployment.

---

## Core takeaway

**Management group scope + subscription scope = valid**  
because subscription is the immediate child.

**Management group scope + resource group scope = invalid**  
because Azure does not allow skipping layers.

