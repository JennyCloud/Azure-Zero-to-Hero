#!/bin/bash
# =========================================
# File: create-network.sh
# Purpose: Create an Azure Virtual Network (VNet), Subnet, NSG, and Public IP
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"
vnetName="LabVNet"
subnetName="WebSubnet"
nsgName="WebSubnet-NSG"
pipName="WebPublicIP"
vnetPrefix="10.0.0.0/16"
subnetPrefix="10.0.1.0/24"

# ---------- Step 1. Ensure Resource Group ----------
echo "Checking if Resource Group '$rgName' exists..."
exists=$(az group exists --name "$rgName")
if [ "$exists" != true ]; then
  echo "Resource Group not found. Creating '$rgName'..."
  az group create --name "$rgName" --location "$location" --output none
fi

# ---------- Step 2. Create Virtual Network ----------
echo "Creating Virtual Network '$vnetName'..."
az network vnet create \
  --resource-group "$rgName" \
  --name "$vnetName" \
  --address-prefix "$vnetPrefix" \
  --subnet-name "$subnetName" \
  --subnet-prefix "$subnetPrefix" \
  --output table

# ---------- Step 3. Create Network Security Group ----------
echo ""
echo "Creating Network Security Group '$nsgName'..."
az network nsg create \
  --resource-group "$rgName" \
  --name "$nsgName" \
  --location "$location" \
  --output table

# ---------- Step 4. Add NSG Rule ----------
# Allow inbound HTTP (80) for web traffic
az network nsg rule create \
  --resource-group "$rgName" \
  --nsg-name "$nsgName" \
  --name "Allow-HTTP" \
  --protocol Tcp \
  --direction Inbound \
  --priority 100 \
  --source-address-prefixes "*" \
  --destination-port-ranges 80 \
  --access Allow \
  --output table

# ---------- Step 5. Associate NSG with Subnet ----------
echo ""
echo "Associating NSG '$nsgName' with subnet '$subnetName'..."
az network vnet subnet update \
  --resource-group "$rgName" \
  --vnet-name "$vnetName" \
  --name "$subnetName" \
  --network-security-group "$nsgName" \
  --output none

# ---------- Step 6. Create Public IP ----------
echo ""
echo "Creating Public IP '$pipName'..."
az network public-ip create \
  --resource-group "$rgName" \
  --name "$pipName" \
  --sku Basic \
  --allocation-method Static \
  --output table

# ---------- Step 7. Summary ----------
echo ""
echo "✅ Network setup complete!"
echo "VNet: $vnetName"
echo "Subnet: $subnetName"
echo "NSG: $nsgName"
echo "Public IP: $pipName"
echo "------------------------------------------------------------"

: '
=========================================================
Explanation:

1. RESOURCE GROUP
   - We first confirm whether the Resource Group exists before creating it.
   - This ensures scripts can be re-run safely (idempotent behavior).

2. VIRTUAL NETWORK
   - az network vnet create builds a new VNet and an initial subnet.
   - Address space 10.0.0.0/16 allows up to 65,000 private IPs.

3. NETWORK SECURITY GROUP (NSG)
   - NSGs act like firewalls controlling inbound/outbound traffic.
   - By default, all inbound is denied, all outbound is allowed.
   - We explicitly create an inbound HTTP rule on port 80.

4. ASSOCIATE NSG
   - Each subnet can have exactly one NSG.
   - Associating links your traffic rules to that subnet.

5. PUBLIC IP
   - Provides an external-facing IP address for VMs or Load Balancers.
   - Static allocation ensures the IP doesn’t change after reboots.

6. OUTPUT FORMATS
   - "--output table" provides a clean view for humans.
   - Other options: json, yaml, tsv (for scripting pipelines).

🧭 Key Takeaways
1. Azure CLI mirrors PowerShell concepts: VNet, Subnet, NSG, Public IP.
2. Networking is best built explicitly for reusable architecture (instead of letting VM creation handle it automatically).
3. Associating NSGs manually gives you full control of traffic flow and security posture.

RESULT:
You now have a complete virtual network stack:
- VNet with address space 10.0.0.0/16
- Subnet 10.0.1.0/24 secured by NSG
- Public IP ready for your VM or Load Balancer
=========================================================
'
