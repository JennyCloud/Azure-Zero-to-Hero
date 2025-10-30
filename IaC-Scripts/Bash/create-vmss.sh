#!/bin/bash
# =========================================
# File: create-vmss.sh
# Purpose: Deploy a Virtual Machine Scale Set (VMSS) connected to a Load Balancer
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"
vmssName="WebApp-VMSS"
lbName="Web-LB"
backendName="LB-Backend"
vnetName="LabVNet"
subnetName="WebSubnet"
image="Win2022Datacenter"
adminUser="azureuser"
instanceCount=2

# ---------- Step 1. Display Info ----------
echo "------------------------------------------------------------"
echo "Deploying VM Scale Set '$vmssName' in Resource Group '$rgName'..."
echo "------------------------------------------------------------"

# ---------- Step 2. Create the VM Scale Set ----------
# The --backend-pool-name flag links this VMSS to your existing load balancer
az vmss create \
  --resource-group "$rgName" \
  --name "$vmssName" \
  --location "$location" \
  --image "$image" \
  --upgrade-policy-mode "Automatic" \
  --admin-username "$adminUser" \
  --generate-ssh-keys \
  --instance-count "$instanceCount" \
  --vnet-name "$vnetName" \
  --subnet "$subnetName" \
  --lb "$lbName" \
  --backend-pool-name "$backendName" \
  --public-ip-per-vm false \
  --output table

# ---------- Step 3. Verification ----------
echo ""
echo "Listing all instances in Scale Set '$vmssName'..."
az vmss list-instances \
  --resource-group "$rgName" \
  --name "$vmssName" \
  --output table

# ---------- Step 4. Check Load Balancer Connection ----------
echo ""
echo "Verifying backend pool association..."
az network lb address-pool show \
  --resource-group "$rgName" \
  --lb-name "$lbName" \
  --name "$backendName" \
  --output table

# ---------- Step 5. Display Public IP of Load Balancer ----------
echo ""
publicIp=$(az network public-ip show \
  --resource-group "$rgName" \
  --name "Web-PublicIP" \
  --query "ipAddress" -o tsv)
echo "Public IP of Load Balancer: $publicIp"
echo "Try opening http://$publicIp in a browser once IIS is installed."

# ---------- Step 6. Optional Cleanup ----------
# Uncomment to delete the scale set
# az vmss delete --name "$vmssName" --resource-group "$rgName" --yes
# echo "Scale set deleted."

: '
=========================================================
Explanation:

1. WHAT IS A VM SCALE SET?
   - A VMSS is a group of identical VMs that scale automatically
     for high availability and load balancing.
   - Ideal for web farms, microservices, or backend worker pools.

2. LINKING TO A LOAD BALANCER
   - "--lb" attaches your scale set to an existing Load Balancer.
   - "--backend-pool-name" links it to the backend pool
     (e.g., "LB-Backend"), so traffic is automatically distributed.

3. INSTANCE COUNT
   - "--instance-count" defines how many VMs to start with.
   - Later you can scale up/down manually or with autoscale rules.

4. UPGRADE POLICY
   - "Automatic" means updates roll out to all instances automatically.
   - You can also use "Manual" or "Rolling" for more control.

5. VERIFICATION
   - az vmss list-instances shows current instances and IDs.
   - az network lb address-pool show confirms back-end registration.

6. LOAD BALANCER PUBLIC IP
   - We fetch the shared front-end IP to verify deployment success.

7. SECURITY NOTE
   - "--public-ip-per-vm false" ensures the VMs aren’t exposed directly;
     all inbound traffic flows through the Load Balancer.

🧭 Key Takeaways
1. VMSS = your “elastic compute” engine — multiple identical VMs managed as one unit.
2. Load Balancer + Backend Pool = the front door that evenly distributes web traffic.
3. You can later apply the autoscaling rules (az monitor autoscale create) just like in your PowerShell version.
4. This script is fully cloud-ready: it works in Azure Cloud Shell, WSL, or any Linux terminal with the Azure CLI.

RESULT:
A load-balanced, auto-scalable web tier that can be scaled or updated
without manual VM management.
=========================================================
'
