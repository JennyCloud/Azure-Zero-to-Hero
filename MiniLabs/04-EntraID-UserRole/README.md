# 🔐 Lab 4 – Microsoft Entra ID User + Role

## 🧠 Overview
This lab demonstrates how to create and manage a user in **Microsoft Entra ID (formerly Azure Active Directory)** using **PowerShell** and assign them a **Reader** role at the resource group level.  
It highlights identity management, access control, and the relationship between users, roles, and resources in Azure.

---

## 🧩 Learning Focus
- Used **PowerShell Cloud Shell** for identity automation  
- Created a new **Entra ID user** with secure credentials  
- Assigned the **Reader** role at the resource group scope  
- Practiced **Identity and Access Management (IAM)** fundamentals  
- Verified permissions and understood **scope hierarchy**

---

## 🌎 Architecture
The lab operates within a single Azure tenant and subscription.  
It connects **Entra ID (Identity layer)** to **Azure Resource Manager (Management layer)**, demonstrating how a user’s identity can be granted controlled access to specific resource groups.

**Components:**
- Tenant: `jennymwanglifegmail.onmicrosoft.com`
- Resource Group: `MiniLabs-RG`
- Role Assigned: `Reader`
- User Created: `LabUser1`

---

## 📸 Result
After running the script, the output confirmed:
- A new Entra user **LabUser1** was created successfully  
- The **Reader** role assignment was applied at the `MiniLabs-RG` scope  

---

## 🧰 Troubleshooting I Did
| Issue | What I Learned / Fix |
|:--|:--|
| **BadRequest Error** | Occurs if the scope string is malformed; fixed by explicitly building the full subscription path. |
| **NotFound Error** | Resource group was deleted earlier; recreated `MiniLabs-RG` before retrying the assignment. |
| **Password Type Error** | PowerShell requires a **SecureString** for passwords; fixed using `ConvertTo-SecureString`. |

Each error provided insight into how Azure validates objects and scopes during IAM operations.

---

## 💬 Q&A Highlights
**Q: What’s the difference between Entra ID and Azure roles?**  
Entra ID controls *who* you are (identity). Azure roles control *what* you can do (authorization).

**Q: Why is “Reader” used in this lab?**  
It’s a safe, non-destructive role that allows visibility into resources without modification rights — perfect for demos.

**Q: How does scope hierarchy work in Azure?**  
Permissions assigned at a higher level (subscription) inherit downward, while resource-group-level roles isolate access.

**Q: What happens if the resource group is deleted?**  
All role assignments scoped to it are automatically invalidated — a key concept in Azure’s resource-based access model.

---

## 🧹 Cleanup Reminder
To keep your environment clean:
- Remove the demo user (`LabUser1`) if not needed.  
- Optionally delete the resource group (`MiniLabs-RG`) to free resources.  

---

## ✅ Summary
This lab completed the **Identity & Access** domain of my Azure foundation.  
It demonstrates secure identity creation, role-based access, and real-world troubleshooting using **PowerShell Cloud Shell** — key skills for Azure administrators.

