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

Azure isn’t a place where people “click create VM and walk away.” It’s a constant dance between performance, cost, compliance, security… and unexpected fires. Below is how each lab task maps to real-world work.

### 1. Creating VMs — but with purpose, not just clicking “Create”

In companies, VMs are created when:

- Developers need a test server  
- A legacy app can't run in App Service or containers  
- Someone needs a jump box / bastion host  
- A client requires a specific Windows or Linux workload  

Admins don’t guess settings. They think about:

- What image? LTS versions only  
- What size? Budget vs performance  
- What region? Compliance + latency  
- What redundancy? Zones, Sets, Scale Sets  
- Networking? Subnet segmentation, NSGs, firewalls  

Portal creation is mainly used for:

- Troubleshooting  
- Emergency deployment  
- One-off dev/test boxes  

For production, code (Bicep/Terraform/GitHub Actions) is the standard.

### 2. Disk Encryption — compliance, audits, and “don’t get fired” security

No one encrypts disks for fun. They do it because:

- Security policy requires it  
- SOC 2, ISO27001, HIPAA, PCI audits check it  
- Customer contracts require customer-managed keys (CMK)  
- Some companies force encryption at the subscription level  

Admins deal with:

- Key rotation  
- Vault access RBAC issues  
- VM extensions getting stuck  
- OS versions not supporting ADE  

When ADE fails, that’s normal — higher security comes with higher friction.

### 3. Moving VMs — often painful, sometimes urgent

Admins move VMs when:

- A team reorganizes and wants resource separation  
- Billing needs cleanup  
- Someone accidentally deployed in the wrong region (this happens weekly at MSPs)  
- A region is too expensive  
- They need availability zones but deployed in a region without them  
- They need to merge or split subscriptions  

Resource moves cause real headaches:

- VM must be deallocated  
- Managed disks can't move across subs without checks  
- Dependencies (NIC, IP, NSG) need to be moved together  
- Region moves require Resource Mover (slow + tricky)  

These moves usually happen during maintenance windows.

### 4. Resizing VMs — performance vs cost chess

Admins resize VMs constantly:

- App is slow → scale up  
- Budget is tight → scale down  
- Licensing: SQL needs specific cores  
- Quota problems force size changes  
- Over-provisioning wastes money  
- Azure Advisor recommends something cheaper  

A very common scenario:

> Developer: "The VM is lagging."  
> Admin: *checks metrics* → CPU fine, memory fine  
> Admin: “Your app is the issue, not the VM.” 😄

Admins mix art + science when choosing sizes.

### 5. Managing VM Disks — storage is where weird things happen

Real tasks include:

- Expanding disks when apps run out of space  
- Migrating OS disk to Premium SSD for performance  
- Adding several data disks for databases  
- Replacing unhealthy disks  
- Cleaning up orphaned disks left behind after VM deletion (every cloud has this mess)  

What breaks most often?

- OS doesn't extend partition automatically  
- Linux disks not mounting on reboot  
- Disk performance throttling (IOPs/BW caps)  
- Accidentally attaching wrong disk to wrong VM  
- Encryption breaking disk swap  

Admins learn patience here.

### 6. Availability Zones & Availability Sets — resilience design

Real work:

- High availability for production apps  
- Avoid downtime during host maintenance  
- App teams expect 99.9–99.99% uptime  
- Redundancy requirements in contracts  
- Disaster recovery designs  

Companies use zones more nowadays because:

- Availability Sets are older technology  
- Zones give stronger SLA  
- Zones isolate hardware physically  

Admins also manage:

- Zonal load balancers  
- Replicated disks across zones  
- Traffic manager / front door for global failover  

Redundancy is a puzzle, and every company solves it differently.

### 7. Virtual Machine Scale Sets — the real production workhorse

In real operations, VMSS is used for:

- Web front-end clusters  
- Application servers  
- Batch processing  
- Autoscaling workloads  
- Containerized apps before AKS migration  

Daily admin tasks:

- Monitoring autoscale events  
- Updating VM images  
- Rolling upgrades  
- Reimaging unhealthy instances  
- Patching through automation  
- Managing LB health probes  
- Debugging failed scale-outs  

VMSS ties directly into:

- CI/CD pipelines  
- Golden image pipelines (Packer, Azure Image Builder)  
- DevOps automation  

This is where Azure Admin meets Azure DevOps.

### Big Picture: What Admins Truly Do with VMs

A real Azure Admin’s brain is juggling:

- Security (RBAC, encryption, key vaults)  
- Performance (sizes, metrics, diagnostics)  
- Cost (rightsizing, shutting down unused VMs)  
- Resilience (zones, VMSS, backups)  
- Automation (Bicep, Terraform, GitHub Actions)  
- Governance (policies, budgets, naming standards)  
- Troubleshooting (why doesn’t this VM connect!?)  
