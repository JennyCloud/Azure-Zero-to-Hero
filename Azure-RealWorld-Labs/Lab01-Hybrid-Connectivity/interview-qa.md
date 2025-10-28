# 💬 Lab 01 Interview Q&A – Hybrid Connectivity
**Author:** Jenny Wang (@JennyCloud)  
**Date:** October 27, 2025  

---

## 🧭 Architecture & Design

**Q1 – Describe the architecture you built.**  
I simulated a hybrid setup with two VNets: one representing Azure and one acting as an on-premises network.  
Each VNet had its own route-based VPN Gateway connected via an IPsec tunnel. Two Windows Server VMs in separate VNets successfully communicated through the tunnel.

**Q2 – Why use route-based instead of policy-based VPNs?**  
Route-based VPNs rely on dynamic routing and are more scalable, making them the preferred option for Azure-to-Azure or hybrid enterprise connections.

**Q3 – Why choose /27 for the GatewaySubnet?**  
Azure gateways run multiple instances for redundancy. A subnet smaller than /27 doesn’t provide enough IP addresses for those instances.

---

## ⚙️ Implementation & Troubleshooting

**Q4 – What problems did you face during deployment?**  
I encountered dynamic IP errors, subnet size limits, blank connection statuses, and a public-IP quota limit.  
Each was resolved by adjusting gateway settings, increasing subnet size, creating reverse connections, and switching VMs to private IP + Bastion access.

**Q5 – How did you confirm the VPN tunnel was active?**  
I ran `Get-AzVirtualNetworkGatewayConnection` to verify both connections were *Connected* with non-zero `EgressBytesTransferred`, and validated with ICMP pings between private IPs.

**Q6 – How did you fix the initial ping failure?**  
I enabled ICMP inbound rules in both Windows firewalls and added an NSG rule allowing ICMP from the `192.168.1.0/24` range.

---

## 🔒 Security & Access Control

**Q7 – How did you secure VM access?**  
I avoided exposing public IPs and used Azure Bastion for RDP connections.  
Only internal subnets were permitted through NSG rules, and ICMP was enabled temporarily for testing.

---

## 🧠 Conceptual Understanding

**Q8 – What’s the difference between VNet Peering and a VPN connection?**  
VNet Peering uses Azure’s private backbone and isn’t encrypted; VPN Gateways use IPsec over the internet, providing encryption and supporting on-prem connectivity.

**Q9 – Why are two connections required (Azure→OnPrem and OnPrem→Azure)?**  
Each gateway maintains its own connection object. Two ensure bi-directional handshakes and symmetric routing.

---

## 📊 Operational Perspective

**Q10 – What would you monitor in production?**  
Gateway bandwidth, latency, uptime, and disconnection events through Azure Monitor and Log Analytics.  
Alerts can trigger automation for reconnection or incident notification.

---

## 💬 Reflection & Learning

**Q11 – What key lesson did you learn?**  
Deploying is straightforward, but troubleshooting Azure’s hidden constraints builds real skill.  
I learned to interpret error codes, plan IP ranges carefully, and document root causes precisely.

**Q12 – How does this lab relate to MSP work?**  
It mirrors daily MSP tasks—configuring hybrid connectivity, resolving customer VPN issues, and documenting outcomes for operational hand-off.

---

### 🧩 Usage
These Q&A notes can be reviewed before interviews or shared in your portfolio to demonstrate both technical knowledge and professional reasoning.

*End of File – Lab 01 Interview Q&A*
