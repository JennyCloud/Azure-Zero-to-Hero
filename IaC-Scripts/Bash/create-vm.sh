#!/bin/bash
# =========================================
# File: create-vm.sh
# Purpose: Deploy a Windows Server virtual machine using Bash and Azure CLI
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
vmName="LabVM01"
location="canadacentral"
image="Win2022Datacenter"
adminUser="azureuser"
port="3389"   # RDP for Windows (use 22 for SSH on Linux)

# ---------- Step 1. Display Setup Info ----------
echo "------------------------------------------------------------"
echo "Deploying VM '$vmName' into Resource Group '$rgName' ($location)"
echo "------------------------------------------------------------"

# ---------- Step 2. Create Resource Group (if not exists) ----------
exists=$(az group exists --name "$rgName")
if [ "$exists" != true ]; then
  echo "Resource Group '$rgName' not found. Creating it now..."
  az group create --name "$rgName" --location "$location" --output none
fi

# ---------- Step 3. Create the Virtual Machine ----------
# This creates a VM, network interface, VNet, NSG, and public IP automatically.
az vm create \
  --resource-group "$rgName" \
  --name "$vmName" \
  --image "$image" \
  --admin-username "$adminUser" \
  --generate-ssh-keys \
  --size "Standard_B1s" \
  --public-ip-sku "Basic" \
  --output table

# ---------- Step 4. Open Port ----------
# Allow inbound traffic on the specified port (RDP or SSH)
az vm open-port \
  --resource-group "$rgName" \
  --name "$vmName" \
  --port "$port" \
  --priority 1000 \
  --output none
echo "Opened port $port on NSG associated with '$vmName'."

# ---------- Step 5. Display Public IP ----------
echo ""
echo "Fetching public IP for '$vmName'..."
publicIp=$(az vm show -d -g "$rgName" -n "$vmName" --query publicIps -o tsv)
echo "Public IP: $publicIp"
echo "You can now connect to your VM using:"
if [ "$port" = "3389" ]; then
  echo "RDP -> $publicIp:$port"
else
  echo "SSH -> ssh $adminUser@$publicIp"
fi

# ---------- Step 6. Verify VM Status ----------
echo ""
echo "Checking VM power state..."
az vm get-instance-view --resource-group "$rgName" --name "$vmName" \
  --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" -o tsv

# ---------- Step 7. Optional Cleanup ----------
# Uncomment to delete the VM and related resources
# echo "Deleting VM '$vmName'..."
# az vm delete --name "$vmName" --resource-group "$rgName" --yes
# echo "VM deletion initiated."

: '
=========================================================
Explanation:

1. VARIABLES
   - rgName, vmName, location, and image define deployment details.
   - adminUser is your local username on the VM.
   - port specifies which service to allow (3389=RDP, 22=SSH).

2. AZ VM CREATE
   - The CLI automatically creates supporting components:
        * Virtual Network (VNet)
        * Subnet
        * Network Interface (NIC)
        * Network Security Group (NSG)
        * Public IP address
   - "--generate-ssh-keys" creates keys for authentication (useful even for Windows).

3. OPEN PORT
   - az vm open-port edits the NSG to allow inbound traffic.
   - Default priority 1000 is fine unless you have custom NSG rules.

4. PUBLIC IP DISPLAY
   - "az vm show -d" retrieves details including public IP.
   - "--query publicIps -o tsv" filters for plain text output.

5. VERIFY STATUS
   - az vm get-instance-view checks whether the VM is running, deallocated, etc.

6. CLEANUP
   - az vm delete removes only the VM; to delete the entire lab, remove the resource group.

🧭 Key Takeaways
1. az vm create automatically provisions networking unless you specify your own.
2. Use --query and -o tsv to extract clean, script-friendly values.
3. The same script works for both Windows and Linux VMs (just change image and port).
4. For automation pipelines, this pattern scales beautifully — easy to loop over many VMs.

RESULT:
You can now deploy and connect to Azure VMs entirely through Bash and Azure CLI.
=========================================================
'
