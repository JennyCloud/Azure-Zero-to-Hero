# Lab 02 – Manage Access to Azure Resources (RBAC Basics)

This lab demonstrates how to manage access to Azure resources using Role-Based Access Control (RBAC).  
I worked with built-in Azure roles, assign roles at different scopes, and interpret effective permissions.  
This lab uses only free-tier features and does not require Microsoft Entra Premium or M365 licensing.

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Manage Azure identities and governance (20–25%)**

Manage access to Azure resources
- Manage built-in Azure roles
- Assign roles at different scopes
- Interpret access assignments

## Real-World RBAC Practices

In real production environments, RBAC is managed with structured, repeatable processes to ensure security, auditing, and operational efficiency. The following summarizes how Azure administrators typically handle access management.

### 1. Role Assignments Are Made to Groups, Not Individuals
Administrators rarely assign roles directly to users.  
Instead, they assign roles to Microsoft Entra groups, and users are added or removed from those groups.  
This improves consistency, simplifies onboarding/offboarding, and reduces permission drift.

### 2. Least Privilege Is Strictly Enforced
Permissions are granted at the minimum level required for a job role.  
Typical patterns include:

- Cloud/Platform Team: Owner or Contributor at management or platform subscriptions  
- DevOps Teams: Contributor at project-level resource groups  
- Developers: Contributor in dev/test, Reader in production  
- Support Teams: Reader or VM Contributor on selected resource groups  
- Auditors: Reader at subscription level  

This reduces the risk of accidental or unauthorized changes.

### 3. Scopes Are Assigned Deliberately
Most assignments occur at the **resource group scope**.  
Subscription-level assignments are used sparingly.  
Resource-level assignments are used only when required to meet specific access boundaries.

### 4. Access Is Automated Using IaC
Large organizations and MSPs automate RBAC using tools such as:

- Bicep or ARM templates  
- Terraform  
- Azure DevOps or GitHub Actions pipelines  
- PowerShell (Az module)

New environments are deployed with predefined access baselines for teams and applications.

### 5. Privileged Identity Management (PIM) Is Used When Available
Organizations with Microsoft Entra ID P2 use PIM to provide just-in-time administration.  
Admins activate high-privilege roles only when needed and actions are fully logged and monitored.

### 6. Access Troubleshooting Is Routine
Common issues investigated by administrators include:

- Incorrect RBAC assignments  
- Permissions inherited from higher scopes  
- Data-plane vs control-plane permissions  
- VNet or firewall restrictions  
- Resource locks  

The “Check access” tool is used heavily to determine effective permissions.

### 7. Naming Conventions Are Standardized
Groups and role assignments follow structured naming patterns such as:

- RG-Prod-Compute-Contributors  
- RG-Dev-Network-Contributors  
- Sub-Global-Readers  
- AppName-Storage-Data-Contributors  

Clear names reduce confusion and simplify audits.

### 8. Activity Logs and Auditing Are Required
Role changes are tracked through Azure Activity Logs and central SIEM systems.  
Organizations often perform quarterly or annual access reviews to maintain compliance.

## Summary of Real-World Patterns

- Roles are assigned to groups, not users  
- Least privilege is the default standard  
- Resource group scope is preferred  
- Automation ensures consistency  
- PIM reduces standing privileges  
- Access issues are resolved through “Check access” and Activity Logs  
- Naming conventions support clarity and auditing  

These practices reflect how production environments manage identity and access securely and efficiently.

