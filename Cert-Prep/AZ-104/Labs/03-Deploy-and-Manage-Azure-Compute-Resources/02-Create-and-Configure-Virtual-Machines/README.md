# Lab 02 - Create and Configure Virtual Machines

This lab walks through core VM administration skills required for AZ-104. All tasks are completed using the Azure Portal to build familiarity with real-world admin workflows.

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Deploy and manage Azure compute resources (20–25%)**

Create and configure virtual machines
- Create a virtual machine
- Configure Azure Disk Encryption
- Move a virtual machine to another resource group, subscription, or region
- Manage virtual machine sizes
- Manage virtual machine disks
- Deploy virtual machines to availability zones and availability sets
- Deploy and configure an Azure Virtual Machine Scale Sets

## Special Note
### Purge Protection
Key Vaults with **purge protection ON** cannot be permanently deleted immediately.

Deletion steps:
1. Delete the Key Vault normally.  
2. It enters **soft-delete** state.  
3. It will be automatically purged after its retention period (7–90 days).  
4. It does not accrue additional cost while soft-deleted.

This is expected and required behavior when using Customer-Managed Keys.

### Existing VMs Cannot Be Added to Availability Sets

Availability sets determine how Azure physically places virtual machines across **fault domains** (different racks/power units) and **update domains** (different maintenance schedules). These placement decisions are made **only at VM creation time**.

When a VM is created inside an availability set, Azure assigns:

- A fault domain (FD)
- An update domain (UD)
- A physical rack/power unit
- Host cluster placement
- Storage cluster metadata linked to the availability set

These properties become part of the VM’s **immutable infrastructure metadata**.

Once the VM exists, Azure cannot safely change:

- Its fault domain or update domain  
- Its physical rack placement  
- Its host cluster assignment  
- Its managed disk alignment to the availability set  
- Its placement group metadata  

Reassigning these would require relocating the VM to a new physical host cluster and rewriting core metadata, which is not supported. Because of this, Azure does **not allow attaching an existing VM** to an availability set.

To place a VM into an availability set, the VM must be **recreated** inside that availability set.

## What Azure Administrators Do in Real Work

Azure virtual machines in production environments are not created or managed casually. Administrators make decisions based on performance, cost, security, governance, and business requirements. Each task in this lab mirrors a common real-world responsibility.

### 1. Creating Virtual Machines

In real environments, VMs are deployed for specific workloads such as development environments, legacy applications, database servers, or jump boxes. Administrators choose:

- The correct OS image
- Region based on latency and compliance
- VM size based on workload needs and budget
- Availability options (zones, sets, scale sets)
- Networking design (VNet segmentation, NSGs, firewalls)

The Azure Portal is mainly used for troubleshooting or emergency deployments. Production deployments typically use automation (Bicep, Terraform, ARM, GitHub Actions, or Azure DevOps).

### 2. Disk Encryption

Disk encryption is used to meet security policies and compliance frameworks such as SOC 2, ISO27001, PCI, and HIPAA. Administrators manage:

- Customer-managed keys (CMK)
- Key vault access policies and RBAC permissions
- Key rotation schedules
- VM extension failures or unsupported OS issues

Encryption failures are common and often caused by unsupported images, restricted regions, or permission misconfigurations.

### 3. Moving Virtual Machines

VMs are moved for reasons such as:

- Subscription or billing restructuring
- Team or department reorganization
- Accidentally deploying to the wrong region
- Migrating to a zone-enabled region
- Consolidation or cost optimization

Moves require planning because VMs must be deallocated, and dependent resources (NICs, IPs, disks, NSGs) must move together. Region moves use Azure Resource Mover and require coordination across teams.

### 4. Managing VM Sizes

Administrators frequently resize VMs to match performance needs or reduce costs. Examples:

- Scaling up when workloads require more CPU or RAM
- Scaling down during cost-optimization or off-hours
- Adjusting VM size due to regional quota limits
- Responding to Azure Advisor recommendations

Performance troubleshooting involves analyzing CPU, memory, disk IOPS, and network metrics to determine whether resizing is appropriate.

### 5. Managing VM Disks

Common real-world disk tasks include:

- Expanding disks when applications run out of space
- Migrating OS or data disks to Premium SSD for higher performance
- Adding multiple data disks for application or database workloads
- Cleaning up orphaned disks after VM deletion
- Fixing OS-level partition issues after resizing

Disk changes require coordination because some OSs need manual partition extension or mount configuration.

### 6. Availability Zones and Availability Sets

High availability is required for production workloads. Administrators use:

- Availability zones for physical isolation and higher SLAs
- Availability sets for update and fault domain separation
- Zonal or zone-redundant load balancers
- Application-aware failover planning

Redundancy is designed based on application requirements, SLAs, and disaster recovery planning.

### 7. Virtual Machine Scale Sets (VMSS)

VMSS are used for scalable, load-balanced workloads such as web front ends, application servers, or batch-processing nodes. Administrators manage:

- Autoscaling rules based on CPU, memory, or custom metrics
- Rolling upgrades for OS or application updates
- Reimaging unhealthy instances
- Golden image pipelines (Packer or Azure Image Builder)
- Integration with CI/CD deployment pipelines
- Load balancer health probe configuration

VMSS operations are tightly integrated with DevOps and automation practices.

### Summary

Real-world Azure VM administration involves balancing security, performance, cost, resilience, compliance, and automation. The tasks in this lab reflect the same responsibilities administrators handle daily in enterprise and MSP (Managed Service Provider) environments.
