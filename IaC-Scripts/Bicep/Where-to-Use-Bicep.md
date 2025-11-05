# 🧱 Where You Can Use Bicep in Azure

Bicep is Microsoft’s **domain-specific language (DSL)** for deploying Azure resources using Infrastructure as Code (IaC).  
It simplifies the process of writing and managing **Azure Resource Manager (ARM)** templates — making deployments more readable, modular, and reusable.

You can use Bicep in **multiple environments** — from the Azure Portal to full automation pipelines.  
This document explains each option and its typical use case.

---

## 🌐 1. Azure Portal

The easiest way to get started with Bicep is directly from the **Azure Portal**.

**How to access it:**
1. Sign in to [Azure Portal](https://portal.azure.com).
2. Search for **Deploy a custom template**.
3. Select **Template deployment (deploy using custom templates)**.
4. Choose **Build your own template in the editor**.
5. Click **Use Bicep** or **Edit in Bicep** to switch to Bicep mode.

You can then paste or load your `.bicep` file, review the automatically generated deployment form, and click **Review + create** to deploy.  
Azure compiles your Bicep code into an ARM template automatically before deployment.

This method is ideal for **testing small templates**, **learning**, or **quick demos** — no command line or tools required.

---

## 💻 2. Azure CLI

The **Azure Command-Line Interface (CLI)** is the most common professional way to deploy Bicep templates.  
It supports compiling, validating, and deploying Bicep files directly, making it ideal for automation scripts and repeatable deployments.  

The CLI is preferred for **automation**, **testing**, and **scripting** across environments.

---

## 🧠 3. Azure PowerShell

If you use PowerShell for automation, you can deploy Bicep templates the same way.  
This integration makes it convenient for **Windows administrators** and hybrid environments where PowerShell scripts are already used for management.

---

## 🧩 4. Visual Studio Code (VS Code)

For writing and testing Bicep, **Visual Studio Code** is the best environment.

**Setup:**
- Install the **Bicep extension** from the VS Code Marketplace.
- It provides IntelliSense, syntax highlighting, and live validation.

You can build and deploy directly from VS Code’s integrated terminal using either Azure CLI or PowerShell.

This setup is ideal for **developers**, **students**, and **DevOps engineers** who want full control and version tracking with GitHub.

---

## 🔄 5. GitHub Actions & Azure DevOps

For **CI/CD automation**, Bicep integrates seamlessly with:
- **GitHub Actions** workflows  
- **Azure DevOps** YAML pipelines  

Both services use Azure CLI or PowerShell commands to compile and deploy Bicep templates automatically.  
This enables **version-controlled**, **auditable**, and **multi-environment** infrastructure management.

---

## 🏗️ 6. Visual Studio & ARM Template Playground

Bicep also works in **Visual Studio** and online tools such as the  
[ARM Template Playground](https://armviz.io) or [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates).

You can convert existing ARM JSON templates into Bicep, visualize resource relationships, and export deployed Azure resources as templates for reuse.  
These tools are helpful for **learning**, **conversion**, and **template visualization**.

---

## 🚀 Summary

| Environment / Tool | Purpose | Typical Use |
|--------------------|----------|--------------|
| **Azure Portal** | Visual and beginner-friendly interface | Quick learning, demos, small templates |
| **Azure CLI** | Command-line automation | Dev/test deployments, scripting |
| **Azure PowerShell** | Windows-based scripting | Admin automation, hybrid management |
| **VS Code** | Authoring environment | Development, validation, Git integration |
| **GitHub Actions / Azure DevOps** | CI/CD pipelines | Automated multi-environment deployments |
| **Visual Studio / ARM Playground** | Visualization & conversion | Advanced authoring, template reuse |

---

## ✅ Final Notes

- Bicep is **fully supported by Microsoft** and constantly updated with new resource types.  
- You can **mix and match environments** — for example, write in VS Code, test in the Portal, and automate with GitHub Actions.  
- Using Bicep helps maintain **clean, repeatable, and version-controlled** infrastructure for all your Azure projects.
