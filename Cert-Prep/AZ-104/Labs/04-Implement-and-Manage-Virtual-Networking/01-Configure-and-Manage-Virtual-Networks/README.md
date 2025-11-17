# Lab 01 - Configure and Manage Virtual Networks

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Implement and manage virtual networking (15–20%)**

Configure and manage virtual networks in Azure
- Create and configure virtual networks and subnets
- Create and configure virtual network peering
- Configure public IP addresses
- Configure user-defined network routes
- Troubleshoot network connectivity

## Special Notes
### We Need Two Directions to Peer Two VNets

Azure VNet peering always consists of **two peering entries**, one on each VNet:

- `vnet-hub01 → vnet-spoke01`
- `vnet-spoke01 → vnet-hub01`

Each VNet keeps its own settings (traffic allowed, forwarded traffic, gateway use).  
Because these settings are independent, both sides must explicitly agree.

If only one side exists, peering shows **Initiated/Disconnected** and traffic won’t flow.

Even when using PowerShell/CLI to create both at once, Azure still creates **two** objects under the hood.

## What Azure Administrators Do in Real Work

Real Azure networking work is less “perfect diagram” and more “someone just broke something at 2 PM.” Administrators spend most of their time building, adjusting, and fixing the same core pieces I practiced in this lab:

### Virtual Networks & Subnets
Admins constantly create new VNets and subnets because every new app, team, or project wants its own space. Address planning (CIDR blocks) matters because overlapping ranges break everything.

### VNet Peering
Peering is used everywhere in hub-and-spoke architectures. Admins check peering health, fix “Initiated/Disconnected” states, and clean up misconfigured gateway transit. Someone always forgets to create the second direction.

### Public IPs
Admins assign, rotate, or secure public IPs for entry points (VMs, Load Balancers, Application Gateways). They make sure nothing critical is exposed by mistake — especially SSH/RDP.

### User-Defined Routes (UDRs)
Admins manage custom routing so traffic flows through firewalls, NVAs, or monitoring appliances. A bad UDR can break an entire subnet, so they spend a lot of time inspecting effective routes and tracing packet paths.

### Network Security Groups (NSGs)
Most connectivity issues come from NSGs blocking traffic. Admins check inbound/outbound rules, NIC-level rules, and subnet rules to figure out which one denies the packet.

### Troubleshooting
This is the daily reality:
- “My VM can’t talk to the database.”
- “The app stopped reaching the API.”
- “Why does my subnet send traffic into a black hole?”

Admins open Network Watcher, run IP Flow Verify, inspect effective routes, check UDRs, confirm peerings, and validate DNS. The job is basically being a network detective.

### Documentation & Cleanup
Networking gets messy fast. Admins document peering maps, keep subnet IP ranges consistent, and clean old resources so routing stays predictable.

## Real-World Azure Networking Troubleshooting Playbook

Azure networking problems usually fall into a small set of recurring causes. Real administrators follow a predictable investigation path — fast, methodical, and evidence-driven. This playbook reflects how issues are actually diagnosed in production.

### 1. Check the Basics First
- Is the VM running?
- Is it in the expected subnet?
- Does it have the right private/public IP?
- Is the NIC attached to the correct VNet?

Most “outages” turn out to be simple misplacements.

### 2. Inspect Network Security Groups (NSGs)
Most connectivity issues come from NSG rules blocking traffic. Admins check:
- Subnet-level NSG
- NIC-level NSG
- Effective security rules

NSGs must allow both inbound and outbound traffic in the right direction.

### 3. Verify VNet Peering State
Admins open both VNets and confirm the peering status shows:
- **Connected / Connected**

If you see:
- **Initiated**
- **Disconnected**
- **Updating**

…then traffic won’t flow.

### 4. Check Effective Routes
User-defined routes (UDRs) can silently redirect traffic into a dead end. Admins look at:
- Effective routes on the VM NIC
- Incorrect 0.0.0.0/0 forced through an appliance
- Next hop types (Virtual appliance, None, Internet)

A single bad route can break a whole subnet.

### 5. Use Connection Troubleshoot (Network Watcher)
Admins run end-to-end tests:
- VM → VM (private IP)
- VM → Public IP
- VM → On-prem endpoints

It tells you *exactly where* the packet is being dropped.

### 6. Use IP Flow Verify
This tool tells you:
- Allowed or denied
- Which NSG rule is responsible

It’s the fastest way to locate a blocking rule.

### 7. Validate DNS
If IP works but hostname doesn’t, admins check:
- VM DNS settings
- Azure DNS (168.63.129.16)
- Custom DNS servers
- DNS suffixes and zones

DNS misconfiguration can mimic “network failures.”

### 8. Capture Logs When Needed
Admins may enable:
- NSG flow logs
- Traffic analytics
- Packet captures

These are used to trace complex flows or intermittent failures.

### 9. Fix and Re-Test Iteratively
Admins change one thing at a time:
- Update NSG → retest  
- Update peering → retest  
- Update UDR → retest  

This prevents introducing new problems while solving old ones.

### 10. Document the Fix
Real-world teams record:
- Root cause  
- What was changed  
- How to avoid it next time  

This reduces repeat outages and improves team knowledge.
