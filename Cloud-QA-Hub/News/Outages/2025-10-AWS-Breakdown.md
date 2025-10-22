# 📰 AWS Outage — October 2025 Breakdown

## 📅 Date
**October 20, 2025**

---

## 🌍 Overview
Amazon Web Services (AWS) experienced a **major outage** primarily affecting the **US-EAST-1 (N. Virginia)** region.  
The disruption caused widespread service interruptions for major platforms such as Snapchat, Fortnite, Venmo, and WhatsApp.

AWS confirmed that the incident was **not caused by a cyberattack**, but by internal infrastructure issues.

---

## ⚙️ Root Cause
- A failure in a **network load balancer health monitoring subsystem**.  
- A **DNS resolution problem** prevented services from connecting to key AWS endpoints like **DynamoDB**.  
- Heavy dependency on the **US-EAST-1** region amplified the impact globally.

---

## 🧠 Key Learnings
- **DNS is critical and fragile:** when internal DNS fails, even healthy services become unreachable.  
- **Single-region dependency** increases risk — many organizations rely too heavily on US-EAST-1.  
- **Monitoring dependencies matter:** AWS’s internal monitoring system failure caused a feedback loop.

---

## 🧰 Prevention & Best Practices
- Implement **multi-region architecture** to distribute workloads.  
- Use **multiple DNS providers** or regional failover DNS zones.  
- Set **short TTLs** (Time-to-Live) for faster DNS record recovery.  
- Continuously **monitor DNS health** using independent services.  

---

## 🧩 Related Topics
- [Why DNS Causes So Many Cloud Outages](../Concepts/DNS-Issues-and-Fixes.md)  
- [Azure Outages and Lessons Learned](../Azure/Azure-Outages-and-Lessons.md)  
- [Cloud Resiliency and Multi-Region Design](../Concepts/Cloud-Resiliency.md)

---

## ✍️ Author
**Jenny Wang**  
*Cloud Enthusiast | AZ-104 in Training*  
🕓 *Created: October 2025*
