# Lab 02 - Configure Secure Access to Virtual Networks


## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Implement and manage virtual networking (15–20%)**

Configure secure access to virtual networks
- Create and configure network security groups (NSGs) and application security groups
- Evaluate effective security rules in NSGs
- Implement Azure Bastion
- Configure service endpoints for Azure platform as a service (PaaS)
- Configure private endpoints for Azure PaaS

## Special Notes
### ASGs

ASGs (Application Security Groups) let us group VMs by **role** instead of **IP address**.  
This makes NSG rules easier to manage, especially when IPs change or when VMs scale.
Azure admins love ASGs because they act like security "tags."

Without ASGs, we must create separate rules for every VM IP.  
With ASGs, we write one rule such as:

**Allow ASG-Web → ASG-DB on port 443**

Any VM added to an ASG automatically inherits the rule.  
ASGs simplify security at scale and prevent constant rule updates.


## What Azure Administrators Do in Real Work
