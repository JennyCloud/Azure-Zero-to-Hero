# 🌐 How Azure Policy *Actually* Behaves  

Azure Policy looks simple on the surface, but the engine under it behaves more like a set of specialized “agents” that react differently depending on how your template is written.  
This guide shows how each effect really works — and why templates can accidentally bypass policy.

---

## ⭐ Modify  
**What it does:**  
Modify *patches* or *injects* properties into a resource *only if those properties exist in the template’s JSON structure.*

**Key rule:**  
Modify **cannot create missing sections**.  
It can *only* patch into structures that already exist.

If your template has no `tags` block, a Modify policy that enforces tags will NOT apply.

Add a tag block — even an empty one — so Modify has something to patch.

**Metaphor:**  
Modify is a painter who can only paint on existing walls.  
If the house has no walls, the painter shrugs and walks away.

---

## ⭐ Audit  
**What it does:**  
Audit logs non-compliant resources.  
It never blocks or changes anything.

**Behavior with templates:**  
Audit happily lets you deploy anything.  
After deployment, the resource is flagged as non-compliant.

**Metaphor:**  
Audit is a security camera.  
It records what happened, but it doesn’t stop anyone.

---

## ⭐ Deny  
**What it does:**  
Deny blocks creation or updates when a resource does not meet the policy conditions.

**Critical detail:**  
Deny can only trigger if the **template’s JSON matches the policy’s expected field paths.**

If the template uses:
- a different API version  
- a different property structure  
- a deeper or higher nested value  

…then Deny cannot “see” the configuration → **deployment is allowed**.

Example mismatch:
- Policy checks `properties.allowBlobPublicAccess`  
- Template defines it under a different structure  

Result: Deny doesn’t match → nothing is blocked.

**Metaphor:**  
Deny is a bouncer checking the guest list.  
If your name is spelled differently, the bouncer doesn’t recognize you — you walk right in.

---

## ⭐ DeployIfNotExists (DINE)  
**What it does:**  
After a resource is created, DINE checks if some configuration is missing.  
If missing, it deploys the required resource *on your behalf*.

**The big catch:**  
DINE requires the **policy assignment’s managed identity** to have permissions (usually Contributor) to deploy the missing configuration.

If permissions are missing:
- deployment succeeds  
- remediation silently fails  

**Template interaction:**  
DINE does not care what your template contains.  
It runs *after* the resource is created.

**Metaphor:**  
DeployIfNotExists is a handyman who fixes things after a house is built.  
If you don’t give the handyman the keys → nothing gets fixed.

---

# 🧠 Summary Table

| Policy Effect | Blocks Deployment? | Changes Resource? | Needs Template Structure? | Needs Permissions? |
|--------------|-------------------|-------------------|---------------------------|--------------------|
| **Audit** | No | No | No | No |
| **Deny** | Yes | No | **Yes — must match fields** | No |
| **Modify** | No | **Yes — patches values** | **Yes — structure must exist** | No |
| **DeployIfNotExists** | No | Yes (after deployment) | No | **Yes — managed identity requires rights** |

---

# 🛠 How Templates Interact with Policy Effects

### Modify  
- Only works if the template contains the JSON structure the policy expects.  
- Missing structure → Modify silently fails.

### Deny  
- Matches JSON field paths exactly.  
- Mismatched paths or different API versions → Deny does not trigger.

### Audit  
- Ignores template content.  
- Evaluates after deployment only.

### DeployIfNotExists  
- Runs after deployment.  
- Template content irrelevant.  
- Requires permissions for remediation.

---

# 🌟 The Big Picture  
Azure Policy is not automatic magic.  
It depends on:
- the exact JSON structure in your templates  
- the policy effect  
- the managed identity permissions  
- the targeted API version  
