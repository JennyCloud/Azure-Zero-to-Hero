# 💎 Lab 04 – Container Instance with Monitoring & Identity

**Date:** November 2025  
**Category:** Azure RealWorld Labs / Containers + Observability  

---

## 🎯 Objective
Deploy a public-facing **Azure Container Instance (ACI)** with:
- **Managed Identity** (System Assigned)  
- **Log Analytics / Container Insights** for diagnostics  
- **Bicep IaC** for repeatable deployments  

This lab demonstrates a lightweight, real-world PaaS-style workload using containers instead of App Services — ideal when subscription quotas restrict App Service Plans.

---

## ⚙️ Deployment (Azure Cloud Shell – PowerShell)

New-AzResourceGroup -Name "ACIRealWorldLab-RG" -Location "EastUS"  
New-AzResourceGroupDeployment -ResourceGroupName "ACIRealWorldLab-RG" -TemplateUri "https://raw.githubusercontent.com/JennyCloud/Azure-Zero-to-Hero/main/Azure-RealWorld-Labs/Lab04-ContainerInstance-Monitoring-Identity/main_aci.bicep"  

---

## 🌐 Verify
1. When the Cloud Shell output shows **ProvisioningState : Succeeded**, the deployment is complete.  
2. In the Azure Portal, open:  
   - **Resource Groups → ACIRealWorldLab-RG → Container Group**  
   - Confirm **Status: Running**  
3. Copy the **FQDN** from the output or the portal → open it in your browser.  
   You should see the default Azure “Hello World from ACI” page.  

---

## 🧭 Why I Chose Azure Container Instance (ACI)
Originally, this lab was intended to deploy an **Azure App Service (PremiumV3)** with autoscaling, staging slots, and Application Insights.  
However, during testing on a **free trial subscription**, I encountered several issues:

- `SubscriptionIsOverQuotaForSku` errors for PremiumV3 and Standard tiers  
- Zero quota for **App Service Plans**, even for the Free (F1) tier  
- Unregistered resource provider: `Microsoft.OperationalInsights`  

These limitations are common for new or credit-based subscriptions.  
To adapt, I redesigned the lab using **Azure Container Instances (ACI)** — which provide similar functionality without needing reserved App Service capacity.  

ACI still illustrates the same professional cloud engineering principles:
- **Infrastructure as Code (Bicep)**  
- **Managed Identity** for secure service access  
- **Monitoring and diagnostics** with Log Analytics  
- **Public accessibility and clean teardown**  

This pivot reflects real-world engineering adaptability — solving constraints while preserving technical depth.

---

## 🧱 Challenges Faced and Lessons Learned
- **Quota restrictions:** Free-tier subscriptions limit many App Service SKUs.  
- **Resource provider registration:** Some Azure services (like Insights) require manual registration before use.  
- **Adaptability:** Real engineers must pivot designs to fit available resources; switching to ACI achieved the same lab goals.  
- **Verification skills:** Practiced validating deployments through both **PowerShell** outputs and **Azure Portal** resources.  

---

## 🧹 Cleanup
Remove-AzResourceGroup -Name "ACIRealWorldLab-RG" -Force  

This deletes the container group, managed identity, and log workspace to stop all charges.

---

## 🧠 Real-World Relevance
This lab demonstrates how **DevOps and MSP engineers** deploy monitored, secure container workloads in Azure using IaC.  
It’s also a real example of troubleshooting under resource limits — an everyday skill in production environments.

**💰 Total Cost:** ~$0.10 for short runtime  
**🕒 Duration:** 10–15 minutes deployment and verification  
