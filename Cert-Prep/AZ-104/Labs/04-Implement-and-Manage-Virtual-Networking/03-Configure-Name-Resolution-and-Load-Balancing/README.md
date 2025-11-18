# Lab 03 - Configure Name Resolution and Load Balancing

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Implement and manage virtual networking (15–20%)**

Configure name resolution and load balancing
- Configure Azure DNS
- Configure an internal or public load balancer
- Troubleshoot load balancing


## What Azure Administrators Do in Real Work

Azure administrators don’t just build load balancers—they maintain them, debug them, and keep traffic flowing despite misconfigurations, firewall surprises, and routing mysteries. Real-world troubleshooting isn’t glamorous, but it’s systematic and reliable. Here’s how admins actually work when a load balancer refuses to behave.

### 1. Health Probes Come First  
Admins know one truth:

**If the health probe is red, nothing will ever work.**

They check:
- Load balancer → Backend pool → Status (Healthy / Unhealthy)
- If no status appears, the rule isn’t bound to the probe correctly.
- If Unhealthy, the LB cannot reach port 80 on the VM.

Instead of testing with browsers, administrators debug the health probe path first.

### 2. Effective Security Rules Over NSG Lists  
The NSG blade may show rules, but **effective security rules** show what Azure actually enforces.

Admins open:
VM → NIC → Effective security rules
They look for:
Source: AzureLoadBalancer
Port: 80
Action: Allow

If missing, they add a rule:
- Source: AzureLoadBalancer  
- Destination port: 80  
- Action: Allow  

This instantly unblocks the load balancer.

### 3. Testing from Inside the VM  
Admins connect to each backend VM and check what the LB expects.

Commands they rely on:

curl localhost
sudo ss -tulpn | grep 80
sudo systemctl status nginx
curl <vm-private-ip>

If localhost works but private IP curl fails → routing issue.
If private IP works but probe fails → NSG or LB binding issue.

### 4. The Azure LB “Rebind Trick”

Admins know Azure sometimes doesn’t bind rules correctly.

The fix:

1. Open the load-balancing rule
2. Re-select the frontend
3. Re-select the backend pool
4. Re-select the health probe
5. Save

This forces Azure to rebuild the rule.
It fixes a surprising number of “mystery” failures.

### 5. Subnets, VNets, and Routes

Admins confirm the fundamentals:

- VMs in the same VNet
- Same region
- Same subnet
- No UDRs pointing traffic to a firewall or appliance that blocks port 80

They open:
VM → NIC → Effective routes

If a UDR redirects port 80 to something else, the LB fails immediately.

### 6. Multi-Angle Testing

Admins test from:

- Another VM in the same VNet
- Cloud Shell
- A jumpbox
- Public internet

Each test reveals a different layer:

- DNS issues
- Routing
- NSG blocking
- Health probe failures
- Backend app issues

They use these results like a map.

### 7. Using Azure Monitor

Admins enable diagnostic logs on the load balancer to see:

- Probe failures
- Backend health events
- Connection drops
Instead of guessing, they read the events.

### 8. Verifying Application Ports

Admins assume the application team is mistaken about which port the app listens on.

They run:
sudo ss -tulpn

If the app is on port 8080 instead of 80, the probe will always fail.
Admins adjust either the probe or the app.

### 9. Backend NIC Configuration

Admins check NIC settings:

- NIC is attached to the correct backend pool
- NIC isn’t pending deletion
- NIC uses the correct IP configuration
- Only one primary IP is active

Even minor NIC issues stop LB traffic.

### 10. The “Remove and Re-Add NICs” Fix

If everything looks correct but still fails, admins know Azure config can become stale.

They do:

1. Remove both VM NICs from backend pool
2. Save
3. Add both NICs back
4. Save again

This re-syncs the LB backend and often fixes silent probe issues.

### The Real Truth

Admins aren’t guessing—they’re methodically verifying:

- Probe health
- Effective NSG rules
- Routing tables
- Port listeners
- Rule bindings
- NIC configuration

Azure networking is deterministic.
A load balancer never “randomly breaks”; it simply reflects a misconfiguration somewhere.
Admins trace each piece until they find the exact point where reality diverges from expectation.
