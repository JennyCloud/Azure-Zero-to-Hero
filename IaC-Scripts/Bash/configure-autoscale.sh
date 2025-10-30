#!/bin/bash
# =========================================
# File: configure-autoscale.sh
# Purpose: Configure automatic scaling for a VM Scale Set (VMSS) using Azure CLI
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
vmssName="WebApp-VMSS"
autoscaleName="WebApp-VMSS-Autoscale"
minCount=1
maxCount=5
defaultCount=2
scaleOutCpu=70    # Scale out if CPU > 70%
scaleInCpu=30     # Scale in if CPU < 30%

# ---------- Step 1. Show Intent ----------
echo "------------------------------------------------------------"
echo "Configuring Autoscale for VMSS: $vmssName"
echo "------------------------------------------------------------"

# ---------- Step 2. Define Autoscale Rules ----------
# Rule 1: Scale OUT when average CPU > 70%
az monitor autoscale rule create \
  --resource-group "$rgName" \
  --autoscale-name "$autoscaleName" \
  --condition "Percentage CPU > $scaleOutCpu avg 10m" \
  --scale out 1

# Rule 2: Scale IN when average CPU < 30%
az monitor autoscale rule create \
  --resource-group "$rgName" \
  --autoscale-name "$autoscaleName" \
  --condition "Percentage CPU < $scaleInCpu avg 15m" \
  --scale in 1

# ---------- Step 3. Apply Autoscale Setting ----------
az monitor autoscale create \
  --resource-group "$rgName" \
  --resource "$vmssName" \
  --resource-type "Microsoft.Compute/virtualMachineScaleSets" \
  --name "$autoscaleName" \
  --min-count "$minCount" \
  --max-count "$maxCount" \
  --count "$defaultCount" \
  --output table

# ---------- Step 4. Verification ----------
echo ""
echo "Listing Autoscale Settings:"
az monitor autoscale show \
  --resource-group "$rgName" \
  --name "$autoscaleName" \
  --output table

: '
=========================================================
Explanation:

1. PURPOSE
   - Autoscale dynamically adjusts the number of VM instances
     according to performance metrics such as CPU usage.

2. AZ MONITOR AUTOSCALE
   - Manages autoscale profiles tied to a specific resource type
     (here, Microsoft.Compute/virtualMachineScaleSets).

3. RULES
   - "az monitor autoscale rule create" adds threshold-based rules.
   - Condition format:
        "MetricName Operator Threshold aggregation Window"
     e.g., "Percentage CPU > 70 avg 10m"
   - "--scale out 1" means add one instance when triggered.
   - "--scale in 1" means remove one instance when triggered.

4. PROFILE SETTINGS
   - Min, Max, and Default counts define capacity boundaries.
   - The system never scales below or above these values.

5. OUTPUT
   - Table format displays readable summaries of rules and profiles.

6. TESTING
   - Generate CPU load in the VMSS to trigger a scale-out event.
   - You can monitor scaling via the Azure Portal or CLI:
         az monitor metrics list --resource "$vmssName"

🧭 Key Takeaways
1. az monitor autoscale is the Azure CLI equivalent of New-AzAutoscaleSetting in PowerShell.
2. The CLI condenses each rule into a single readable condition string.
3. Scaling events appear in the Activity Log and can trigger alerts.
4. This approach is widely used in DevOps automation pipelines for cost efficiency.

RESULT:
Your VMSS now self-adjusts between $minCount and $maxCount instances
based on real-time CPU load.
=========================================================
'
