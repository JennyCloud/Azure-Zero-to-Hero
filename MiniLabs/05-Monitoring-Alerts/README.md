# 📊 Mini Lab 5 – Monitoring & Alerts (Activity Log)

## 🧠 Overview
This lab demonstrates how to monitor Azure resources using **Activity Log Alerts** and **Action Groups**.  
It focuses on real-time visibility and proactive response: when a change (write operation) happens in a resource group, Azure sends an email notification through an Action Group.

All tasks were performed in **PowerShell Cloud Shell** and verified in the **Azure Portal**.

---

## 🧩 Learning Focus
- Registered the **Microsoft.Insights** provider for monitoring services  
- Created an **Action Group** with an email notification  
- Configured an **Activity Log Alert Rule** for all administrative operations  
- Practiced troubleshooting permission and registration issues  
- Verified the alert rule in the **Azure Monitor → Alerts** dashboard  

---

## 🌎 Architecture
| Component | Purpose |
|:--|:--|
| **Resource Group** | `MiniLabs-RG` |
| **Action Group** | `MiniLabs-AG` |
| **Alert Rule** | `RG-Activity-Write-Alert` |
| **Notification** | Email triggered via Action Group |
| **Location** | Canada Central |

When any administrative (write) operation occurs in `MiniLabs-RG`, Azure Monitor detects it and sends an email alert using the linked Action Group.

---

## 🧰 Troubleshooting I Did
| Issue | What I Learned / Fix |
|:--|:--|
| **Unregistered Provider** | Registered `Microsoft.Insights` using `Register-AzResourceProvider`. |
| **Action Group Cmdlet Errors** | Used the Azure Portal to create the Action Group when PowerShell module syntax changed. |
| **Missing Parameters in PowerShell** | The `New-AzActivityLogAlert` syntax varies by module version — portal method ensured consistency. |

Each fix reinforced how Azure’s modular services evolve — an important real-world admin lesson.

---

## 💬 Q&A Highlights
**Q: What is an Action Group?**  
A reusable notification container that can trigger email, SMS, or automation responses when an alert fires.

**Q: Why use Activity Log Alerts instead of Metric Alerts?**  
Activity Log Alerts track control-plane events (like resource creation or deletion), while Metric Alerts track performance data.

**Q: What’s the benefit of “All Administrative operations”?**  
It ensures every configuration or write change triggers visibility — great for auditing and compliance.

**Q: How does registration affect monitoring?**  
If a provider (like `Microsoft.Insights`) isn’t registered, none of its dependent features (alerts, metrics, diagnostics) can be used.

---

## 🧹 Cleanup Reminder
- Delete the alert rule and Action Group after testing to avoid unnecessary notifications.  
- Optionally remove `MiniLabs-RG` if it was created solely for this exercise.

---

## ✅ Summary
This lab completed the **Monitoring & Alerts** domain of the Azure admin foundation.  
I learned how to connect activity monitoring with alert automation — a critical skill for operational visibility and incident response.
