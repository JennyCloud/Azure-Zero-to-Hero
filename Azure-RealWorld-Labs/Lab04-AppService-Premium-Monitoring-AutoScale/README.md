# 💎 Lab 04 – App Service Premium with Monitoring & AutoScale

**Date:** November 2025  
**Category:** Azure RealWorld Labs / PaaS Automation  

---

## 🎯 Objective
Deploy a production-grade **Azure App Service (PremiumV3)** with:
- **Application Insights** monitoring  
- **Staging slot** for Blue-Green deployments  
- **Autoscale** (CPU-based)  
- **Managed Identity**

This lab demonstrates how cloud engineers deploy secure, observable, and scalable PaaS workloads.

---

## ⚙️ Deployment (Azure CLI)

az group create --name AppServicePremiumLab-RG --location eastus  
az deployment group create --resource-group AppServicePremiumLab-RG --template-file main.bicep  

---

## 🌐 Verify
- **Production:** https://<appname>.azurewebsites.net  
- **Staging:** https://<appname>-staging.azurewebsites.net  

Then check in the Azure Portal:
- App Service Plan → Pricing Tier = PremiumV3  
- Deployment Slots  
- Application Insights → Live Metrics Stream  
- Scale Out → Autoscale CPU rule  

---

## 🧹 Cleanup

az group delete --name AppServicePremiumLab-RG --yes --no-wait  

---

## 🧭 Real-World Relevance
- PremiumV3 tier supports advanced scaling and uptime SLAs  
- Application Insights provides continuous monitoring  
- Staging slot enables safe production rollouts  
- Autoscale ensures cost-efficient performance  
- Managed Identity removes secrets and credentials

**💰 Cost:** Under $1 for short testing  
**🕒 Duration:** ~15–20 minutes total
