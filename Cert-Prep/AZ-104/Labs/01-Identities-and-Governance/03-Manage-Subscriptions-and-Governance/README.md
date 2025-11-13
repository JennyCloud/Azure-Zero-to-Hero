# Lab 03 – Manage Azure Subscriptions and Governance  

This lab explores Azure governance features used by administrators to control access, enforce standards, maintain compliance, and manage costs across resource groups and subscriptions.  
The configuration aligns with real MSP and enterprise governance practices and requires only a free Azure subscription.

---

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Manage Azure identities and governance (20–25%)**

Manage Azure subscriptions and governance
- Implement and manage Azure Policy
- Configure resource locks
- Apply and manage tags on resources
- Manage resource groups
- Manage subscriptions
- Manage costs by using alerts, budgets, and Azure Advisor recommendations
- Configure management groups

---

# Governance Concepts Practiced in This Lab

### Resource Groups  
Used to group related resources, standardize region placement, apply tags, and assign RBAC at scale.

### Tags  
Metadata used to identify ownership, environment, cost centers, automation scope, compliance categories, and lifecycle states.  
Tags become essential for Cost Management, budget enforcement, chargeback/showback, and automated cleanup.

### Resource Locks  
Protect mission-critical workloads from accidental deletion or modification, especially in production environments.

### Azure Policy  
A governance engine that enforces rules such as mandatory tags, region restrictions, encryption requirements, or SKU restrictions.  
Deny effects prevent non-compliant resources from deploying.

### Budgets & Cost Alerts  
Used to monitor spending trends and alert administrators or finance teams if projected costs exceed thresholds.

### Azure Advisor  
Provides recommendations for cost optimization, reliability, security posture, and performance improvements.

### Management Groups  
Enterprise-level folders for applying governance, RBAC, and policy across multiple subscriptions.

---

# How Administrators Use These Tools in Real Work

### 1. Governance Is Applied at Scale  
Admins rarely configure resources individually.  
Standards are applied at the management group or subscription level so all resources inherit rules automatically.

Examples:  
- Mandatory encryption  
- Required tags  
- Region restrictions  
- Monitoring agents enforced through policy  

This ensures consistency across large environments.

### 2. Tags Drive Cost Accountability  
Organizations depend heavily on tags to identify:

- Who owns the resource  
- Which department pays for it  
- What project it belongs to  
- Whether it can be deleted  
- Which costs should be charged back  

Missing tags cause financial reporting gaps, so admins enforce them through policy.

### 3. Locks Protect Critical Workloads  
Admins place Delete or ReadOnly locks on high-value resources such as databases, VNets, or production resource groups to prevent accidental outages.

### 4. Policy Prevents Human Error  
Azure Policy automatically blocks deployments that violate organizational standards.  
Admins use it to enforce:

- Region rules  
- Encryption  
- SKU restrictions  
- Tag requirements  
- No public endpoints  
- Logging/monitoring requirements  

Policy is the safety net that keeps environments compliant.

### 5. Budgets Prevent Unexpected Charges  
Budgets and alerts help admins catch cost spikes early, such as:

- Premium resources deployed by mistake  
- High-volume logging  
- Unexpected data egress  
- Over-sized VMs  

Alerts notify teams before the monthly bill becomes a problem.

### 6. Advisor Recommendations Are Reviewed Regularly  
Organizations review Azure Advisor monthly for:

- Cost optimization  
- Security hardening  
- Reliability improvements  
- Performance tuning  

These insights feed into operational and financial reporting.

### 7. Management Groups Provide Structure  
Management Groups serve as top-level folders.  
Admins use them to separate workloads by customer, environment, department, or compliance boundary.

Policies and RBAC applied here cascade down automatically.

### 8. Governance Is Automated Using IaC  
In real-world environments, governance baselines are deployed through:

- Bicep  
- ARM templates  
- Terraform  
- GitHub Actions  
- Azure DevOps Pipelines  

Automation ensures reproducibility and prevents configuration drift.

