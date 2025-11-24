# Troubleshooting Scenario #12 — Azure Load Balancer Health Probe Always Shows Unhealthy

## Situation
You deploy an **Azure Standard Load Balancer** with backend VMs.

You configure:

- Backend Pool  
- Health Probe  
- Load Balancing Rule  

But the health probe status shows:

- **Unhealthy** for all VMs  
- **0/2 healthy instances**  
- **Backend pool is empty** (because probe fails)

And the load balancer never sends traffic to the VMs.

This is one of the most important AZ-104 troubleshooting cases, because health probes are brutally strict — if the probe fails, the VM is treated as non-existent.

---

## How to think about it

A health probe works like this:

Azure → VM  
Azure asks: “Are you alive on *this port/path*?”

If **any** of these fail:

1. Azure cannot REACH the VM  
2. The VM does not LISTEN on the probe port  
3. The VM’s NSG does NOT allow probe traffic  
4. The VM responds too SLOWLY  
5. The probe PATH (for HTTP) is incorrect  

Then the probe is **Unhealthy**, and traffic stops.

---

## Most common causes

### 1. NSG does not allow the AzureLoadBalancer service tag
The NSG must allow:

- Source: **AzureLoadBalancer**  
- Destination: **VM IP**  
- Port: **probe port**

If missing → probe fails instantly.

This is the #1 real-world cause.

---

### 2. The application isn’t listening on the port the probe expects
Common mistakes:

- Probe uses port 80  
- Web server is listening on 8080 → Unhealthy  

- Probe uses TCP  
- App requires HTTP response → Unhealthy  

- Probe uses HTTP GET `/`  
- App actually uses `/health` → Unhealthy  

---

### 3. VM firewall (inside the OS) blocks the port
Windows Defender Firewall or Linux iptables may block:

- inbound port  
- or only allow localhost  

Azure NSG isn’t the only firewall.

---

### 4. Application takes too long to reply
If probe timeout is 5 seconds and your app responds in 6–7 seconds:

Probe = Unhealthy  
Even though the app is “technically working but slow.”

---

### 5. Wrong probe PATH (for HTTP probes)
Example:

Probe URL: `/healthz`  
App actually serves `/health`  

Probe never succeeds.

---

### 6. VM is using a custom route table that breaks probe traffic
If UDR sends all traffic to:

- A firewall  
- A dead appliance  
- `0.0.0.0/0 → None`  

The probe packets never arrive.

---

## How to solve it — the admin sequence

### Step 1 — Check health probe configuration
Confirm:

- Port  
- Protocol (TCP/HTTP)  
- Path (if HTTP)  
- Interval + timeout  

Often a small mismatch causes the problem.

---

### Step 2 — Validate the service is listening on the probe port
SSH/RDP into VM:

Windows:
netstat -ano | findstr :<port>

Linux:
sudo ss -tulpn | grep <port>


If nothing is listening → unhealthy.

---

### Step 3 — Check NSG inbound rules
Must allow:

- Source: **AzureLoadBalancer**  
- Destination: VM  
- Port: probe port  

If missing → probe fails.

---

### Step 4 — Check OS-level firewall
Windows Firewall or iptables may block inbound probe traffic.  
Allow the port manually if needed.

---

### Step 5 — Test the probe endpoint manually
From inside the VM:

curl http://localhost:<port>/<path>


If this fails → app misconfiguration.

---

### Step 6 — Check UDRs (route tables)
If UDR hijacks traffic, the probe cannot reach the VM.  
Ensure routes allow probe traffic from Azure.

---

### Step 7 — Check VM performance
High CPU/memory may slow down probe response, causing intermittent unhealthy states.

---

## Why follow these steps?

The health probe depends on this exact sequence:

1. **Load Balancer sends probe**  
2. **Network path must allow traffic (NSG + UDR)**  
3. **VM OS must allow traffic (firewall)**  
4. **Application must listen on correct port**  
5. **Application must respond quickly**  
6. **Probe must match correct path/protocol**  

Checking out of order creates confusion:

- Fixing NSG won’t help if app doesn’t listen  
- Fixing app won’t help if UDR blocks traffic  
- Fixing probe config won’t help if OS firewall blocks  
- Fixing OS firewall won’t help if path is wrong  

You always follow the packet’s journey.
