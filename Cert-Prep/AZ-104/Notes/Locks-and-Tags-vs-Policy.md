# Why Locks and Tags Don’t Work at the Management Group Level

Azure draws a boundary between **governance objects** (like management groups and the Tenant Root Group) and **resource objects** (subscriptions, resource groups, resources). Locks and tags belong strictly to the resource layer, so they cannot attach to governance objects.

---

## 1. Locks Live in the Resource Plane

Azure locks (ReadOnly/Delete) operate only within the **Azure Resource Manager (ARM)** hierarchy:

- Subscription  
- Resource group  
- Resource  

Management groups are not ARM resources. They exist in the **governance plane**, which means locks have nowhere to “attach.” Allowing locks at this level would create massive, unpredictable inheritance effects across all subscriptions—something Microsoft avoids deliberately.

---

## 2. Tags Also Belong to the Resource Plane

Tags are designed for:

- cost tracking  
- metadata  
- automation  
- grouping  

These systems evaluate **resources** and **subscriptions**, not management groups. Tags do not inherit, and Azure intentionally avoids tag inheritance at the governance level because it would create conflicts and ambiguity.

---

## 3. The Tenant Root Group Is Immutable by Design

The Tenant Root Group functions as the top-level anchor of the entire hierarchy. It cannot be:

- locked  
- tagged  
- renamed  
- deleted  

Azure must preserve one immutable root for governance consistency.

---

## 4. Policy, Not Locks/Tags, Governs the Management Group Layer

At the management-group level, Azure expects you to use:

- **Azure Policy** for governance  
- **RBAC** for access control  

Policies *do* inherit through management groups, unlike tags or locks.
