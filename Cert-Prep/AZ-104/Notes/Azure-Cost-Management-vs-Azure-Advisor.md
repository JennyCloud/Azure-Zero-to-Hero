# Azure Cost Management vs Azure Advisor

Azure Cost Management focuses on **tracking, analyzing, and controlling** your cloud spending.  
Azure Advisor focuses on **improving efficiency**, including cost, performance, security, and reliability.

---

## Purpose
| Service | Purpose |
|---------|---------|
| **Azure Cost Management** | Understand and manage cloud spending: usage, costs, budgets, exports. |
| **Azure Advisor** | Provide actionable recommendations across cost, performance, reliability, security, and operations. |

---

## What It Does
### Azure Cost Management:
- Breaks down cost by subscription, resource group, resource, tag  
- Provides cost analysis charts  
- Forecasts future spending  
- Creates **budgets + alerts**  
- Exports cost data to Storage or Log Analytics  
- Helps answer: *“Where is our money going?”*

### Azure Advisor:
- Audits your environment  
- Identifies wasted resources  
- Suggests optimizations:  
  - Underutilized VMs → resize or shut down  
  - Idle NICs, IPs, disks → delete  
  - VMSS optimization  
  - ExpressRoute redundant config  
  - Security misconfigurations  
  - Reliability risks  
- Helps answer: *“How can we improve our environment?”*

---

## Scope of Recommendations
| Advisor Category | What It Covers |
|------------------|------------------|
| **Cost** | Unused/underused resources, over-provisioned VMs |
| **Performance** | VM bottlenecks, database issues |
| **Reliability** | High availability issues |
| **Security** | Security Center integration |
| **Operational Excellence** | Governance & best practice improvements |

Cost Management only deals with **money**.  
Advisor deals with **money + performance + security + reliability**.

---

## Data Source
| Service | Data Source |
|---------|-------------|
| **Azure Cost Management** | Billing + usage data from Azure Commerce API |
| **Azure Advisor** | Telemetry + metadata from Azure Monitor, Resource Graph |

---

## Alerts
- **Cost Management** → budget alerts (“you exceeded $2000 this month”)  
- **Advisor** → recommendation alerts (“resize VM X to save $60/month”)

---

## Typical Usage Scenarios
### When to use Cost Management:
- You want a breakdown of monthly cost by service.  
- Finance wants forecasting.  
- You need to find which resource group is most expensive.  
- You need to enforce a budget alert.  
- You want to export billing data.

### When to use Advisor:
- You want to reduce waste.  
- You want idle VMs identified automatically.  
- You want security recommendations.  
- You want performance or HA (reliability) improvements.

---

## Key Exam Clue  
> If the question mentions **“recommendations”**, think **Azure Advisor**.  
> If the question mentions **“cost analysis, budgets, alerts, exports”**, think **Azure Cost Management**.

---

## Summary
**Azure Cost Management = Analyze and control spending**  
**Azure Advisor = Automatic best-practice recommendations (including cost savings)**

