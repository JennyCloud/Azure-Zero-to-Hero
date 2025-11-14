# Real-World Storage Access Management in Azure

This document explains how Azure administrators actually secure and manage access to storage accounts in production environments. These notes complement the AZ-104 lab on storage firewalls, SAS tokens, stored access policies, access keys, and Azure Files identity-based access.

---

## 1. Storage Firewalls & Virtual Networks
In production environments, storage accounts are never left open to `All Networks`.  
Admins restrict access using:

- Virtual Networks and subnets  
- Private Endpoints (Private Link)  
- IP allowlists only for break-glass access  
- Default-deny inbound configuration  

This prevents unauthorized data access and ensures the storage account is reachable only from approved workloads.

### Typical Production Pattern
Application → VNet/Subnet → Private Endpoint → Storage Account  
All public traffic → Blocked

If a request comes from outside the trusted VNet, it is denied.

---

## 2. SAS Tokens (Shared Access Signatures)
SAS tokens provide temporary delegated access. Admins treat them as high-risk and enforce:

- Very short expiration times  
- Minimal required permissions  
- Logging and monitoring of usage  
- Automation-based issuance (Key Vault, pipelines)  
- No long-lived SAS tokens  
- No sharing SAS via email or chat  

### Real-World Use
A data pipeline uploads files for 10 minutes using a SAS that expires immediately afterward.

---

## 3. Stored Access Policies
Stored Access Policies provide centralized control for SAS:

- You can revoke all SAS tokens instantly  
- You can update permissions without regenerating tokens  
- Policies are required for large-scale automation  
- Prevent forgotten SAS tokens with extended access  

### Real Benefit
One stored access policy can manage all SAS tokens used by an entire team or application.

---

## 4. Access Keys
Access keys provide full administrative access to a storage account. Admins avoid them whenever possible.

### Real Usage
- Keys are stored only in Azure Key Vault  
- Keys are rotated on a schedule (monthly/quarterly)  
- Logs track every operation involving key usage  
- Keys are never emailed or copied to local files  
- Modern workloads rarely use keys  

### Best Practice
Disable “Allow storage account key access” unless absolutely necessary.

---

## 5. Azure Files Identity-Based Access
Azure AD identity-based access replaces passwords and keys.

Admins assign RBAC roles to users or groups:

- Storage File Data SMB Share Reader  
- Storage File Data SMB Share Contributor  
- Storage File Data SMB Share Owner  

### Real Workflow
1. User requests access.  
2. Admin assigns the appropriate RBAC role.  
3. User mounts the share using Azure AD credentials.  
4. Disabling the user’s account removes access automatically.

This aligns with enterprise IAM and eliminates secret rotation.

---

## 6. Automation
Real-world Azure storage administration is automated using:

- PowerShell (Az Module)  
- Azure CLI  
- Bicep / ARM templates  
- Terraform  
- GitHub Actions / Azure DevOps  
- Azure Policy (security enforcement)  

Automation ensures consistent, secure deployments with no manual mistakes.

### Example
A GitHub Actions workflow deploys storage with:
- Private endpoints  
- Firewall rules  
- SAS policies  
- Diagnostic logging  
- Security baselines  

---

## 7. How Real Work Differs from Labs
Labs teach:
- SAS  
- Keys  
- Stored policies  
- Azure Files SMB  

Real work adds:
- Identity-based access  
- Private networking  
- RBAC  
- Governance  
- Monitoring  
- Automation  

Labs build the foundation; production environments add security and scale.

---

## Summary
Azure storage security in the real world relies on:

- Identity over keys  
- Private access over public endpoints  
- Automation over manual operations  
- Policies and governance over ad-hoc configuration  

These practices align with enterprise, MSP, and cloud security best practices and support AZ-104 and AZ-305 skills.

