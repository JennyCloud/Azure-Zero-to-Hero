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

## Key Vault Special Note  
Key Vaults with **purge protection ON** cannot be permanently deleted immediately.

Deletion steps:
1. Delete the Key Vault normally.  
2. It enters **soft-delete** state.  
3. It will be automatically purged after its retention period (7–90 days).  
4. It does not accrue additional cost while soft-deleted.

This is expected and required behavior when using Customer-Managed Keys.
