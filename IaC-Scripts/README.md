# 🧱 IaC-Scripts

**Infrastructure as Code (IaC)** scripts for automating Azure resource deployment, configuration, and management.  
This folder serves as a central hub for PowerShell, Bash, ARM, and Bicep scripts — each demonstrating different ways to build and manage Azure environments.

---

## 🧠 About This Folder

Each subfolder shows a different approach to Azure automation:

| Folder | Tool | Description |
|:--|:--|:--|
| **PowerShell** | Az PowerShell module | Full automation and scripting control, ideal for admins. |
| **Bash** | Azure CLI | Lightweight and cross-platform, great for quick tasks or Cloud Shell. |
| **ARM** | JSON templates | Declarative IaC for repeatable, version-controlled deployments. |
| **Bicep** | Bicep DSL | Modern and simplified IaC language that compiles into ARM templates. |

---

## 💡 Best Practices

- Keep scripts **modular** and **idempotent** (safe to run multiple times).  
- Include comments and clear parameter sections at the top of each file.  
- Use descriptive naming — e.g. `create-vmss.ps1` or `cleanup-network.sh`.  
- Version-control templates and keep credentials out of the repo.  
- Commit updates after each verified deployment to maintain clean history.  

---

## 🧰 Skills Demonstrated

- Azure PowerShell & CLI automation  
- Infrastructure as Code (ARM & Bicep)  
- Scripting fundamentals and DevOps readiness  
- Cloud resource lifecycle management  

---

## 🪴 Author Notes

All scripts in this folder are part of my personal Azure learning and lab portfolio.  
They demonstrate practical, hands-on experience with real-world cloud administration and DevOps practices.

---

📘 *“Automate once, repeat forever — that’s the Azure way.”*
