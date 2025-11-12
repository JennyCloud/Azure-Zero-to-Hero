# 🧩 Lab 01 – Manage Microsoft Entra Users and Groups (Free Tier Edition)

## 🎯 Objective

This lab demonstrates how to manage **Microsoft Entra ID (formerly Azure AD)** users, groups, and guest access using the **Free Tier** of Azure.  
Even without Microsoft 365 or Premium licenses, we can still explore core identity management concepts hands-on.

---

## 🧠 Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Manage Azure identities and governance (20–25%)**
Manage Microsoft Entra users and groups
- Create users and groups
- Manage user and group properties
- Manage licenses in Microsoft Entra ID
- Manage external users
---

## 💡 Real-World Context

In enterprise or MSP environments:
- **PowerShell and Microsoft Graph API** are used for bulk automation.  
- **Dynamic groups** and **license-based access** simplify lifecycle management.  
- **Microsoft Entra Connect** syncs on-prem AD users to the cloud.  
- **Premium features (P1/P2)** add Conditional Access, SSPR for all users, and Identity Governance.  

🧠 *Admins rarely manage users manually — automation and governance policies ensure consistency and security.*

---

## 🧭 Q&A Highlights

| Question | Answer |
|-----------|---------|
| Can I create users without licenses? | Yes — unlicensed users can sign in and access basic Azure services. |
| Why is SSPR limited? | It requires Microsoft Entra ID Premium P1 or above for user groups. |
| Can I invite guests with a free tenant? | Yes, B2B collaboration is available for all Entra tenants. |
| What’s the next step after this lab? | Automate user and group creation using PowerShell and Microsoft Graph. |
