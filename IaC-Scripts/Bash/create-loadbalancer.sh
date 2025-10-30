#!/bin/bash
# =========================================
# File: create-loadbalancer.sh
# Purpose: Deploy a Public Load Balancer with frontend, backend, probe, and rule
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"
lbName="Web-LB"
pipName="Web-PublicIP"
backendName="LB-Backend"
probeName="TCP-Probe"
ruleName="HTTP-Rule"
vnetName="LabVNet"
subnetName="WebSubnet"

# ---------- Step 1. Check Resource Group ----------
exists=$(az group exists --name "$rgName")
if [ "$exists" != true ]; then
  echo "Resource Group '$rgName' not found. Creating it..."
  az group create --name "$rgName" --location "$location" --output none
fi

# ---------- Step 2. Create Public IP ----------
echo "Creating Public IP '$pipName'..."
az network public-ip create \
  --resource-group "$rgName" \
  --name "$pipName" \
  --sku Basic \
  --allocation-method Static \
  --output table

# ---------- Step 3. Create Load Balancer ----------
echo ""
echo "Creating Load Balancer '$lbName'..."
az network lb create \
  --resource-group "$rgName" \
  --name "$lbName" \
  --sku Basic \
  --frontend-ip-name "LB-Frontend" \
  --backend-pool-name "$backendName" \
  --public-ip-address "$pipName" \
  --output table

# ---------- Step 4. Create Health Probe ----------
echo ""
echo "Adding health probe '$probeName' on port 80..."
az network lb probe create \
  --resource-group "$rgName" \
  --lb-name "$lbName" \
  --name "$probeName" \
  --protocol Tcp \
  --port 80 \
  --interval 5 \
  --threshold 2 \
  --output table

# ---------- Step 5. Create Load Balancer Rule ----------
echo ""
echo "Adding Load Balancer rule '$ruleName'..."
az network lb rule create \
  --resource-group "$rgName" \
  --lb-name "$lbName" \
  --name "$ruleName" \
  --protocol Tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name "LB-Frontend" \
  --backend-pool-name "$backendName" \
  --probe-name "$probeName" \
  --output table

# ---------- Step 6. Summary ----------
echo ""
echo "✅ Load Balancer setup complete!"
echo "------------------------------------------------------------"
echo "Resource Group: $rgName"
echo "Load Balancer: $lbName"
echo "Frontend IP:   $pipName"
echo "Backend Pool:  $backendName"
echo "Probe:         $probeName"
echo "Rule:          $ruleName"
echo "------------------------------------------------------------"

: '
=========================================================
Explanation:

1. PURPOSE
   - A load balancer evenly distributes inbound traffic to multiple backend VMs.
   - Common use case: scaling web servers across a pool of instances.

2. PUBLIC IP
   - Required for inbound internet traffic.
   - Basic SKU with Static allocation keeps the same IP for testing.

3. LOAD BALANCER CREATION
   - az network lb create automatically sets up:
       * Frontend IP configuration
       * Backend address pool

4. HEALTH PROBE
   - Checks backend instance health before routing traffic.
   - If a VM stops responding on port 80, it’s temporarily removed from rotation.

5. LOAD BALANCER RULE
   - Defines how incoming traffic (port 80) maps to backend pool VMs (port 80).
   - Protocol can be TCP or UDP.
   - Each rule links a frontend IP, backend pool, and health probe.

6. SCALABILITY
   - You can later attach:
       - Individual VMs (via NIC backend association)
       - Or an entire VM Scale Set (automatically registered)

7. OUTPUT
   - "--output table" prints clear results.
   - "✅" and "echo" statements make the script readable during long runs.

🧭 Key Takeaways
1. Load balancers are stateless, distributing incoming traffic evenly.
2. Probes keep the system resilient — unhealthy VMs are bypassed automatically.
3. You can later attach backend VMs or a VM Scale Set using az network nic ip-config address-pool add or directly via az vmss create.
4. This is the same structure Azure uses behind many managed services (App Gateway, AKS Load Balancer, etc.).

RESULT:
You now have a working Load Balancer that’s ready to distribute traffic
to multiple backend VMs or a scale set, with automatic health checks.
=========================================================
'
