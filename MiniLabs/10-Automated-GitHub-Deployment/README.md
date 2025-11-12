# Mini Lab 10 – Automated Deployment Using GitHub Actions (Free-Tier Edition)

This mini lab demonstrates how to deploy Azure resources using a fully automated GitHub Actions workflow. Instead of deploying resources manually in the Azure Portal, infrastructure is deployed automatically whenever changes are pushed to the repository. This workflow mirrors real-world Azure administration and MSP practices.

---

## 🎯Objectives

- Deploy Azure resources automatically  
- Store Infrastructure-as-Code (Bicep) in GitHub  
- Use Azure federated identity (OIDC) for passwordless authentication  
- Validate and track deployments through workflow run history  
- Capture logs for portfolio documentation

---

## 🧩Architecture

Repository → GitHub Actions → OIDC Login → Azure CLI → Deployment → Resource Group

---

## 🔐Federated Identity (OIDC)

The workflow uses a Microsoft Entra App Registration with a GitHub federated credential.  
The App Registration is assigned the **Contributor** role on `MiniLab10-RG`.

Required GitHub secrets:

AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID


---

## 📜Workflow Run History

Workflow runs appear under:

**GitHub → Actions → Deploy Bicep to Azure**

- Workflow run history  
- Timestamps  
- Success and failure indicators  
- Full deployment logs  

These logs show Azure CLI commands, deployment status, and resource creation details.

---

## 🔍Verification in Azure

After a successful workflow run, open:

Azure Portal → Resource groups → `MiniLab10-RG`

A Storage Account with a unique generated name will appear.  
This confirms that GitHub Actions successfully deployed the Bicep template.
