# ☁️ Mini Lab 1 — Azure Storage 101 (PowerShell + Cloud Shell)

### 🧩 Objective  
Create an Azure Storage Account, a private container, upload a text file, and generate a secure SAS URL for temporary access.

---

## 📜 Script Location  
All PowerShell commands for this lab are saved under  
[`scripts/storage101.ps1`](./scripts/storage101.ps1)

---

## 🧠 Key Concepts
- **Resource Group:** Logical container for Azure resources.  
- **Storage Account:** Entry point for blob, file, queue, and table services.  
- **Blob Container:** Folder-like object inside the storage account.  
- **Context ($ctx):** Connection object with credentials and endpoints.  
- **SAS Token:** Temporary key that grants fine-grained access without exposing full credentials.  
- **Content-Type:** Determines whether the browser downloads or renders the blob.

---

## 🧩 Reflection
This mini-lab introduces:
- The **idempotent pattern** (check → create)
- Using **Context** for authenticated operations
- Secure blob access with **SAS**
- Understanding **Content-Type** and default download behavior


