# 🚀 08 – Bicep VM Fleet

### Goal
Deploy 10 identical Azure Virtual Machines using a Bicep loop. Each VM gets its own NIC and public IP within a shared virtual network.

---

### Key Concepts
- **Looping:** `for i in range(1, vmCount + 1)` dynamically creates resources.
- **Dynamic Naming:** VM names are generated as `vm1`, `vm2`, ... `vm10`.
- **Dependencies:** Each VM depends on its NIC and subnet.
- **Parameterization:** VM size, image, and credentials are reusable.

---
### Deployment

# Log in
az login

# Choose your resource group
az group create -n BicepVMFleet-RG -l eastus

# Deploy
az deployment group create \
  --resource-group BicepVMFleet-RG \
  --template-file main.bicep \
  --parameters @parameters.json

---

### Verification
In the Azure Portal:
- Check the resource group → you should see 10 VMs, 10 NICs, 10 Public IPs, and 1 VNet.
- Use az vm list -g BicepVMFleet-RG -o table to confirm deployments.

---

### Clean Up
az group delete -n BicepVMFleet-RG --yes --no-wait

