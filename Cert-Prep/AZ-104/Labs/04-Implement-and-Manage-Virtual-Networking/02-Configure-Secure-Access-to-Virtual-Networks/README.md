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
### Application Security Groups

ASGs let us group VMs by **role** instead of **IP address**.  
This makes NSG rules easier to manage, especially when IPs change or when VMs scale.
Azure admins love ASGs because they act like security "tags."

Without ASGs, we must create separate rules for every VM IP.  
With ASGs, we write one rule such as:

**Allow ASG-Web → ASG-DB on port 443**

Any VM added to an ASG automatically inherits the rule.  
ASGs simplify security at scale and prevent constant rule updates.


## What Azure Administrators Do in Real Work

Network security work in Azure looks glamorous in labs, but in the real real world it’s closer to being a digital detective with a flashlight and a whiteboard.  
Admins spend their days following packets, unraveling rule conflicts, and preventing small misconfigurations from turning into production outages.

Here’s what this lab maps to in actual day-to-day Azure operations:

### 🛡️ 1. NSGs & ASGs — The Weekly Battle Against “Why can’t it connect?”
Admins constantly troubleshoot why some VM can’t reach:

- a database  
- an API  
- a storage account  
- another VM  
- a private endpoint  
- an internal Load Balancer  

In real life, someone will say:

> “It worked yesterday, but now it’s broken.”

Then admins follow the traffic hop-by-hop:

1. NIC NSG  
2. Subnet NSG  
3. ASG memberships  
4. Route table  
5. DNS  
6. Private endpoint mappings  
7. Firewall policies  
8. Network Virtual Appliance bypass rules  

And 70% of the time, the problem is:

- Someone forgot to add the VM to an ASG.  
- A new NSG rule has a lower priority and silently blocked traffic.  
- A subnet NSG overrides a NIC NSG.  
- Route table points traffic away to a firewall that denies it.

ASGs especially save sanity — VMs scaling up/down without IP stability is normal, so grouping by function is essential.

### 🔍 2. Effective Rules — The Truth Layer
Admins use “Effective Security Rules” constantly.  
It’s how they debug complex rule overlap.

In real work, the first thing you check is:

> “What is *actually* being applied?”

Because NSG behavior is like a layered sandwich:

- Default rules  
- Subnet rules  
- NIC rules  
- ASG rules  
- ARM policies  
- Security Center recommendations  
- Firewall rules  
- UDR (User-Defined Routes)

If anything in that chain disagrees, traffic dies quietly.

Admins often draw diagrams or use `az network watcher` to trace flows.

### 🔒 3. Bastion — No More Public SSH/RDP
Companies rarely allow VMs with public IPs anymore.

Real admins deploy:

- Zero-trust  
- Jump hosts  
- JIT access  
- Bastion  
- Conditional Access  
- MFA  
- RBAC segmentation  

Bastion removes:

- Brute-force attacks on SSH/RDP  
- NIC exposure  
- Extra firewall rules  
- Public IP management

Admins love Bastion because it solves 10 problems in one click.

### 🌐 4. Service Endpoints — Legacy but Still Everywhere
Service endpoints are used when:

- A company wants to restrict Storage access to internal networks  
- They haven’t migrated to Private Endpoints yet  
- They need fast throughput into PaaS over Microsoft’s backbone  
- Simpler architecture is fine

Admins choose service endpoints when:

- They want security but don’t need fully private DNS  
- They’re on older VNets  
- They want to avoid private DNS complexity

But they’re being replaced by…

### 🕳️ 5. Private Endpoints — The Modern Standard
Private Endpoints are now everywhere for compliance reasons:

- Healthcare  
- Finance  
- Government  
- Education  
- Enterprise  
- MSP/Ops teams  

They give:

- Private IP  
- Private DNS  
- Zero exposure  
- Full isolation  
- Works with firewall bypass rules  
- Logs and traffic visibility

The new pattern for everything in Azure is:

> “If it’s PaaS and production:  
> use Private Endpoint.”

Admins spend a lot of time fixing DNS around private endpoints:

- Wrong DNS zones  
- Missing A-records  
- VM using 8.8.8.8 instead of Azure DNS  
- Hybrid network recursive resolver misconfigurations  

When DNS is wrong, private endpoints instantly break.

### ⚠️ 6. Real Work = Migration Pain
Admins often migrate old systems:

- From public endpoints → private endpoints  
- From service endpoints → private endpoints  
- From flat VNets → hub-and-spoke  
- From manual NSGs → ASG-based rules  
- From unmanaged public IPs → Bastion  
- From old Classic VNets → ARM VNets  

The painful parts:

- Downtime windows  
- Old IP-based rules  
- Legacy systems that “break silently”  
- Developers who hardcoded public URLs  
- Firewalls that drop packets without logging  

Network work is rarely glamorous—it’s mostly detective work.

### 🧰 7. Real Tools Admins Use Daily

- **Network Watcher** — Packet capture, flow logs, next-hop analysis  
- **Azure Firewalls / Palo Alto / Fortigate** — Where most traffic *actually* gets blocked  
- **Log Analytics** — Querying NSG flow logs with KQL  
- **Azure Monitor Alerts** — Triggering when private endpoint DNS fails  
- **Terraform/Bicep GitOps** — Because nobody configures production firewalls manually anymore  
- **Diagrams & Architecture docs** — Because networks get complex fast

### 🌱 The Big Picture
Everything in this lab mirrors real enterprise behavior:

- Lock down VMs  
- No public IPs  
- Use Bastion  
- Use ASGs for scale  
- Use NSGs at subnet level  
- Use service endpoints only if private endpoints aren’t available  
- Use private endpoints for secure PaaS  
- Debug all connectivity with “Effective Rules”  
- Trace traffic using Network Watcher  

That’s the daily reality for Azure network/security admins.
