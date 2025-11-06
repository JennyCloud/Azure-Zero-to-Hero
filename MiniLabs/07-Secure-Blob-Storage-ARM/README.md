# ☁️ Mini Lab 07 – Secure Blob Storage via ARM Template

**Objective:** Deploy a hardened Azure Storage Account with private blob access and 7-day soft delete using a declarative **ARM (Azure Resource Manager)** template.

---

## 🧩 Resources Created
- **Storage account:** `StorageV2` type, HTTPS-only, TLS 1.2, no public access  
- **Blob service:** Enabled delete-retention (soft delete) for 7 days  
- **Container:** `data` (Private access level)

---

## 🧠 Concepts Demonstrated
- Declarative deployment using **Infrastructure-as-Code (ARM)**  
- **Resource dependency chain:** Storage → Blob Service → Container  
- Security hardening: TLS 1.2+, HTTPS-only, and public access disabled  
- **Soft delete protection** validated via recovery test

---

## 🧪 Verification Steps
1. Upload any blob to the `data` container.  
2. Delete it → confirm recovery using **Show deleted blobs → Undelete**.  
3. Inspect configuration:  
   - *Secure transfer = Enabled*  
   - *Minimum TLS = 1.2*  
   - *Public access = Disabled*

---

## 🧰 Export & Reuse
The exported template (`template.json` + `parameters.json`) can be redeployed to any region or subscription with a new storage account name.

To redeploy in Azure CLI:
```bash
az deployment group create \
  --resource-group rg-arm-minilab \
  --template-file template.json \
  --parameters parameters.json
