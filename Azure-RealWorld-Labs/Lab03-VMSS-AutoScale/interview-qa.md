# 💬 Interview Q&A — Lab 3: Azure VM Scale Set with Load Balancer

### 🔹 Concept Overview  
This lab demonstrates how to create a **Virtual Machine Scale Set (VMSS)** that automatically installs **IIS** on deployment and connects to an existing **Azure Load Balancer (LB)**.  
The architecture ensures **high availability**, **scalability**, and **automated management** of web servers under load.

---

## 💡 Common Interview Questions & Answers

### 1️⃣ What is a Virtual Machine Scale Set (VMSS)?  
A **VM Scale Set** is an Azure compute resource that lets you deploy and manage a group of identical, load-balanced VMs.  
It supports **auto-scaling** and keeps applications highly available even when demand fluctuates.

---

### 2️⃣ What’s the difference between VMSS and creating multiple VMs manually?  
Manually created VMs must be configured and updated one by one.  
A **VMSS** uses a **single configuration model**, so all instances share the same OS image, extensions, and scaling rules—simplifying management and scaling.

---

### 3️⃣ What are the two orchestration modes for VMSS?  
- **Uniform mode** – All instances are identical and managed as a group; best for stateless apps.  
- **Flexible mode** – Allows different VM sizes and configurations in one set; best for stateful or mixed workloads.

---

### 4️⃣ How does a Load Balancer distribute traffic to the VMSS?  
The **Azure Load Balancer** spreads incoming traffic across healthy VM instances using:  
- **Backend pool** – links VMSS NICs  
- **Health probe** – checks instance health  
- **Load-balancing rule** – defines frontend-to-backend traffic flow

---

### 5️⃣ What’s the purpose of a health probe?  
A **health probe** regularly checks each VM (e.g., port 80).  
If a VM fails to respond, it’s temporarily removed from the backend pool until it recovers, ensuring consistent traffic distribution.

---

### 6️⃣ Why was IIS installed using CustomData instead of manually?  
**CustomData** enables VMSS instances to **self-configure on deployment** — a form of bootstrap automation.  
Each new instance automatically runs the setup script to install IIS, guaranteeing uniform configuration across the scale set.

---

### 7️⃣ What’s the advantage of using a Uniform VMSS with a Load Balancer?  
- Simplifies horizontal scaling (add/remove instances easily)  
- Ensures consistent configuration  
- Reduces maintenance overhead  
- Integrates with auto-scaling and update domains

---

### 8️⃣ What if the Load Balancer public IP doesn’t respond in the browser?  
Check these points in order:  
1. Verify the NSG allows inbound TCP port 80.  
2. Confirm the health probe is linked to the load-balancing rule.  
3. Re-run `Install-WindowsFeature Web-Server` if IIS failed.  
4. Ensure the backend pool has at least one connected VM.

---

### 9️⃣ How does scaling work in a VMSS?  
Scaling can be **manual** (by adjusting capacity) or **automatic** (based on metrics like CPU usage).  
Azure adds or removes instances as needed while keeping load-balancer connections stable.

---

### 🔟 What happens to a failed VM in a scale set?  
If a VM becomes unhealthy, the scale set automatically recreates it from the base configuration, preserving availability and consistency.

---

### 1️⃣1️⃣ How does this lab relate to real-world production systems?  
In real-world deployments:  
- Web servers commonly run behind VMSS + LB for scalability.  
- Configuration is automated via scripts or extensions.  
- Auto-scaling and monitoring ensure performance and cost control.

---

## 🧠 Key Takeaways
- **VMSS + LB** = Azure’s foundation for scalable web applications.  
- **Uniform mode** fits identical stateless workloads.  
- Always verify **NSG**, **probe linkage**, and **IIS setup** before testing.  
- **Automation reduces human error** and keeps deployments consistent.
