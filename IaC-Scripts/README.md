# 🧱 IaC-Scripts

**Infrastructure as Code (IaC)** scripts for automating Azure resource deployment, configuration, and management.  
This folder serves as a central hub for PowerShell, Bash, ARM, and comparison guides — each demonstrating different ways to build and manage Azure environments.

---

## 🧠 About This Folder

Each subfolder showcases a different approach or perspective on Azure automation:

| Folder | Tool / Purpose | Description |
|:--|:--|:--|
| **PowerShell** | Az PowerShell module | Full automation and scripting control — ideal for administrators managing hybrid or Windows-heavy environments. |
| **Bash** | Azure CLI | Lightweight and cross-platform — perfect for quick deployments, scripting in Cloud Shell, or Linux-based workflows. |
| **ARM** | JSON templates | Declarative Infrastructure-as-Code for consistent, version-controlled deployments. |
| **Bicep** | Modern ARM DSL | A simplified, human-readable language that compiles to ARM templates — used for modular, repeatable, and cleaner IaC design directly supported by Microsoft. |
| **Tools-Comparison** | Conceptual guides | Comparison and roadmap documents explaining how tools like PowerShell, Bash, ARM, Bicep, Terraform, and Copilot relate in the automation ecosystem. |

---

## 💡 Best Practices

- Keep scripts **modular**, **idempotent**, and easy to debug.  
- Include comments and clear parameter sections at the top of each file.  
- Use descriptive naming — e.g., `create-vmss.ps1` or `deploy-network-arm.json`.  
- Exclude credentials or secrets from the repository.  
- Commit after each verified deployment to maintain a clean and traceable history.  

---

## 🧰 Skills Demonstrated

- Azure PowerShell & CLI scripting  
- Infrastructure as Code with ARM & Bicep  
- Tool comparison and automation strategy design  
- DevOps and CI/CD pipeline readiness  
- Cloud resource lifecycle and monitoring automation  

---

## 🪴 Author Notes

All scripts and documents in this folder are part of my personal Azure learning and hands-on lab portfolio.  
They reflect real-world, scenario-based experimentation with Infrastructure as Code, automation workflows, and DevOps integration.

---

📘 *“Automate once, repeat forever — that’s the Azure way.”*
