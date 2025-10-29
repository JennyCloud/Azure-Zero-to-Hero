# 💬 Interview Q&A — Lab 02: Load Balancing & High Availability  
**Author:** Jenny Wang (@JennyCloud)

This Q&A summarizes how I would explain the design, configuration, and troubleshooting steps of my Azure Load Balancer lab in an interview.  
The focus is on practical reasoning — not memorized theory — to reflect real-world cloud engineering skills.

---

### ❓Q1: What was the main goal of this lab?
**A:**  
To build a fault-tolerant web environment using an Azure Standard Load Balancer that distributes HTTP traffic across two IIS web servers.  
The goal was to demonstrate high availability, network security, and the ability to troubleshoot end-to-end connectivity between public and private resources.

---

### ❓Q2: Why did you use a *Standard Load Balancer* instead of Basic?
**A:**  
Standard SKU is production-grade — it supports availability zones, higher SLA, and advanced rules like outbound SNAT control.  
MSPs and enterprise environments almost always standardize on the Standard SKU for security and scalability.

---

### ❓Q3: How did you configure the backend pool and health probe?
**A:**  
I created a backend pool (`LB-Backend`) containing both VM NICs (`WebVM1` and `WebVM2`).  
Initially, I used an HTTP probe checking `/`, but it failed because IIS sometimes returned non-200 codes during setup.  
I replaced it with a simpler TCP probe on port 80 — a common real-world fix when testing labs or non-web workloads.

---

### ❓Q4: What caused the “Trusted Launch” VM creation error, and how did you handle it?
**A:**  
Free-tier subscriptions don’t always have the **Microsoft.Compute/StandardSecurityTypeAsFirstClassEnum** feature registered.  
This prevented PowerShell from creating VMs with the *Standard* security type.  
I resolved it by deploying the VMs through the Azure Portal (which defaults to compatible security settings) and re-attaching them to the network manually — a good example of practical adaptation when automation fails.

---

### ❓Q5: How did you verify the Load Balancer was working?
**A:**  
I first tested both IIS servers individually with their private IPs to ensure they responded.  
Then I accessed the Load Balancer’s public IP (e.g., `http://20.63.9.175`) and confirmed responses came alternately from both servers.  
The probe health and inbound rules in the Azure Portal also showed a *Connected* status.

---

### ❓Q6: What troubleshooting steps did you take when the LB IP didn’t respond?
**A:**  
I validated the flow layer by layer:
1. Checked the NSG rules to ensure ports 80 and 3389 were open.  
2. Used `Test-AzNetworkConnectivity` to confirm the VMs were reachable.  
3. Replaced the HTTP probe with a TCP probe (simpler and more reliable).  
4. Verified IIS status using `Invoke-WebRequest` on localhost from each VM.  
This approach follows the same systematic troubleshooting process used by MSPs during production incidents.

---

### ❓Q7: What’s the difference between *Application Gateway* and *Load Balancer*?
**A:**  
Azure Load Balancer operates at **Layer 4 (Transport Layer)** — it handles TCP/UDP traffic.  
Application Gateway works at **Layer 7 (Application Layer)** — it understands HTTP/HTTPS, supports SSL offloading, WAF, and routing based on URLs.  
In short, Load Balancer = fast packet routing; App Gateway = intelligent traffic management.

---

### ❓Q8: How would you improve this design for enterprise use?
**A:**  
- Add **Availability Zones** or **VM Scale Sets** for true redundancy.  
- Use **Azure Bastion** for secure RDP access instead of opening port 3389.  
- Integrate **Azure Monitor** alerts for probe health.  
- Deploy via **ARM templates** or **Bicep** for repeatability.  
- Enable **HTTPS termination** through App Gateway in front of the LB.

---

### ❓Q9: What key lessons did you learn from this lab?
**A:**  
- Diagnose layer by layer — network, security, application.  
- “HTTP probe failing” ≠ “Load Balancer broken.”  
- Real-world engineers must balance **automation**, **security**, and **manual flexibility**.  
- Documentation (scripts, screenshots, fixes) is part of professional cloud engineering.

---

### ❓Q10: If an MSP interviewer asked, “Why is this lab relevant to our clients?”, how would you answer?
**A:**  
Because hybrid and managed environments depend on predictable uptime.  
This lab proves I can deploy, secure, and troubleshoot Azure infrastructure that keeps customer services online.  
It reflects the same skill set MSP engineers use when configuring production load balancers, maintaining SLAs, and diagnosing traffic or health probe issues in live systems.

---

✅ **Result:**  
Two IIS servers balanced under one public IP, resilient to single-VM failure.  
The design demonstrates my practical understanding of Azure networking, availability, and real-world incident troubleshooting — exactly what MSPs and Cloud Ops teams value.
