# Connected Registry in Azure Container Registry (ACR)

A **connected registry** is an **edge replica** of an Azure Container Registry (ACR).  
It allows container images to be cached, pulled, and synchronized in **offline or intermittently connected environments** such as factories, ships, retail stores, or isolated networks.

The connected registry acts as a **child registry**, while the main ACR in Azure acts as the **parent**.

---

## What a Connected Registry Does

### **Local Image Caching**
A connected registry stores a local copy of container images so edge devices pull images from a nearby source rather than from Azure.  
This improves performance and keeps workloads running even when the internet is slow or unavailable.

### **Automatic Synchronization**
When connectivity is available:
- New images are synchronized from the parent ACR to the connected registry.
- Updates or usage data can flow back to the cloud.

### **Offline Operation**
A connected registry continues to serve images even if Azure is unreachable.  
This is essential for industrial or remote environments that cannot rely on continuous connectivity.

### **Scoped Access**
You can limit which repositories or tags the connected registry can sync or expose.  
Useful for isolated teams or compliance boundaries.

---

## Why Connected Registries Exist

Many real-world environments cannot depend on stable cloud connectivity:
- Manufacturing plants with isolated networks  
- Ships or oil rigs with poor satellite links  
- Hospitals with restricted traffic  
- Retail stores with limited WAN capacity  

These systems still need:
- Containerized applications  
- Image updates  
- Local deployments  
- Operational continuity during outages  

A connected registry provides this functionality without requiring constant access to Azure.

---

## Analogy

A connected registry is like a **local refrigerated storage unit** in a remote shop.  
The main bakery (ACR) supplies the cakes.  
The store keeps a local copy so customers can buy cakes even when the delivery truck can’t reach the shop due to weather or road closures.  
When the roads reopen, the fridge syncs again with the bakery.

---

## Exam Clues: When to Choose Connected Registry

Connected registry is usually the right answer when you see keywords such as:
- Edge computing  
- Offline or intermittent network  
- On-premises container runtime  
- Industrial IoT  
- “Images must be available during network outages”  
- “Synchronize container images to local sites”

---

A connected registry is essentially **ACR for the edge**, allowing reliable and secure container operations in disconnected or partially connected environments.
