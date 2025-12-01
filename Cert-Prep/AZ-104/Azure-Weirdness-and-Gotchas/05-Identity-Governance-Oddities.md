# Identity & Governance Oddities

## Custom Security Attributes
- Cannot be assigned to groups.
- Only work with: users, service principals, managed identities.
- Used for ABAC policies.

## Azure Role-Based Access Control (RBAC)
- Tagging VMs requires VM-level write permissions.
- Assigning roles at the resource group level may still fail if resource providers aren’t registered.

## Entra ID vs Azure AD DS
- Azure AD DS is not a cloud domain controller replacement.
- You cannot create new forests or domain trusts.

## Azure Policy
- Some policies operate in "Audit" mode only.
- Deny policies only work when resource providers support them.

## Licensing
Qroup-based licensing in Microsoft Entra ID supports security groups (including mail-enabled security groups) and Microsoft 365 groups that have securityEnabled=TRUE.
