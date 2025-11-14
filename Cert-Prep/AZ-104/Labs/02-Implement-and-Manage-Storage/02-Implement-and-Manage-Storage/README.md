# Lab 2 – Implement and Manage Azure Storage (Free-Tier Edition)

## Lab Summary
This lab demonstrates how to deploy, configure, and manage Azure Storage using the Azure Portal and operational tools such as Storage Explorer and AzCopy. I configured redundancy, enable data-protection settings, set up Object Replication between two storage accounts, and implement Customer-Managed Keys (CMK) using Azure Key Vault. The lab mirrors real-world cloud administration practices and aligns with AZ-104 exam objectives.

## Objectives
- Create and configure Azure Storage accounts  
- Configure LRS, ZRS, GRS, and RA-GRS redundancy  
- Enable versioning, soft delete, and change feed  
- Configure Object Replication between accounts  
- Configure storage encryption using Customer-Managed Keys  
- Manage data using Azure Storage Explorer  
- Upload/download blobs using AzCopy  

## Real-World Administrator Practices

Azure administrators manage storage using automation, strict security controls, and well-defined operational habits. The tasks in this lab closely mirror how storage is handled in real MSP and enterprise environments.

### 1. Automated Resource Deployment  
In production, storage accounts are rarely created manually. Administrators use:
- Bicep
- Terraform
- GitHub Actions or Azure DevOps pipelines

Clicking through the portal is mainly reserved for troubleshooting or demonstrations.

Naming conventions also follow strict patterns such as:

st<dept><env><region><workload>

Example: 'stfinprdcaeastapp01'

### 2. Standardized Data Protection Settings  
Admins consistently enforce:
- Blob versioning  
- Soft delete for blobs and containers  
- Change feed  
- Immutability policies (for finance, healthcare, and legal workloads)

These prevent data loss from accidental deletes, ransomware, and misconfiguration.

### 3. Intentional Redundancy Choices  
Azure Storage redundancy (LRS, ZRS, GRS, RA-GRS) is chosen based on business needs:

- **LRS:** Development or low-risk workloads  
- **ZRS:** High-availability workloads within a single region  
- **GRS / RA-GRS:** Disaster recovery, cross-region resilience, and compliance

Certain redundancy changes require recreating the storage account, so admins plan transitions carefully.

### 4. Object Replication for Cross-Region Resilience  
Object Replication is used for:
- Multi-region application distribution  
- Central logging  
- Disaster recovery  
- Compliance retention

Administrators typically automate OR configuration with Terraform or Bicep, keeping regions paired and failover-ready.

### 5. Customer-Managed Keys (CMK) for Regulated Industries  
Enterprise workloads often require encryption using keys stored in Key Vault.  
Admins manage:
- Key Vault access policies  
- Key rotation  
- Key versioning  
- Auditing of key usage

This is standard in finance, healthcare, government, and large SaaS providers.

### 6. Daily Use of Azure Storage Explorer  
Storage Explorer remains an everyday tool because it enables quick:
- Blob inspection  
- Uploads and downloads  
- SAS URL generation  
- Troubleshooting replication and versioning issues  

It's lightweight and faster for ad-hoc operations than the portal.

### 7. AzCopy for Migrations and Bulk Transfer  
AzCopy is the primary tool for:
- Moving terabytes of data  
- Seeding backups  
- Syncing containers  
- Pulling forensic logs  
- High-speed migration into Azure Storage  

It’s faster and more resilient than portal uploads and integrates well with automation pipelines.

### 8. Strict RBAC and Access Control  
Admins use RBAC roles such as:
- Storage Blob Data Contributor  
- Storage Blob Data Reader  
- Key Vault Crypto User  

They avoid giving out account keys or overly-broad SAS tokens unless absolutely required.

### 9. Storage Monitoring and Alerts  
Operational monitoring includes alerts for:
- Capacity thresholds  
- Replication lag  
- Authentication failures  
- Key expiration  
- Deletion attempts  

Alerts integrate with Azure Monitor, Log Analytics, or SIEM tools like Sentinel.

### 10. Lifecycle Management for Cost Optimization  
Admins implement rules to automatically move data:
- From hot → cool  
- From cool → archive  
- Delete after a defined retention period  
- Retain only necessary blob versions  

This prevents unnecessary storage spending and keeps large accounts manageable.
