#!/bin/bash
# =========================================
# File: monitoring-and-alerts.sh
# Purpose: Create Azure Monitor metric & activity log alerts for a VMSS
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"
vmssName="WebApp-VMSS"
actionGroupName="VMSS-ActionGroup"
actionShort="vmssag"
emailName="NotifyEmail"
emailAddr="you@example.com"
metricAlertName="VMSS-CPU-High"
activityAlertName="VMSS-Autoscale-Activity"
cpuThreshold=80
severity=3        # 0=Critical … 4=Verbose

# ---------- Step 1. Create Action Group ----------
echo "Creating Action Group '$actionGroupName'..."
az monitor action-group create \
  --resource-group "$rgName" \
  --name "$actionGroupName" \
  --short-name "$actionShort" \
  --action email "$emailName" "$emailAddr" \
  --output table

# ---------- Step 2. Create Metric Alert (CPU > threshold) ----------
echo ""
echo "Creating Metric Alert '$metricAlertName' for high CPU..."
az monitor metrics alert create \
  --name "$metricAlertName" \
  --resource-group "$rgName" \
  --scopes "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$rgName/providers/Microsoft.Compute/virtualMachineScaleSets/$vmssName" \
  --condition "avg Percentage CPU > $cpuThreshold" \
  --description "Warn when VMSS average CPU exceeds ${cpuThreshold}%." \
  --severity "$severity" \
  --action-groups "$actionGroupName" \
  --output table

# ---------- Step 3. Create Activity Log Alert (Autoscale events) ----------
echo ""
echo "Creating Activity Log Alert '$activityAlertName'..."
az monitor activity-log alert create \
  --name "$activityAlertName" \
  --resource-group "$rgName" \
  --scopes "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$rgName" \
  --condition category=Autoscale \
  --action-groups "$actionGroupName" \
  --description "Notify when Autoscale triggers a scale-in or scale-out event." \
  --output table

# ---------- Step 4. Verify ----------
echo ""
echo "Listing all alerts in resource group '$rgName'..."
az monitor metrics alert list --resource-group "$rgName" --output table
az monitor activity-log alert list --resource-group "$rgName" --output table

: '
=========================================================
Explanation:

1. ACTION GROUP
   - An Action Group defines *who gets notified*.
   - You can include emails, webhooks, ITSM, SMS, or Azure Functions.
   - "az monitor action-group create" sets one up with your email.

2. METRIC ALERT
   - "az monitor metrics alert create" watches a metric, such as CPU.
   - Condition syntax:
        avg <MetricName> > <Threshold>
   - If the average CPU exceeds 80%, an email is sent.
   - Severity levels: 0 (Critical) → 4 (Informational).

3. ACTIVITY LOG ALERT
   - Watches the Azure Activity Log for specific events.
   - Here, we alert whenever category = "Autoscale".
   - That means you’ll be notified each time the VMSS scales in or out.

4. VERIFICATION
   - Use list commands to confirm alerts are registered correctly.
   - Alerts also appear under Azure Portal → Monitor → Alerts.

5. SECURITY NOTE
   - Keep email addresses private in public repos.
   - You can parameterize with environment variables instead.

🧭 Key Takeaways
Action Groups centralize alert delivery (email, webhook, etc.).
Metric Alerts react to live performance metrics.
Activity Log Alerts track operational events like autoscaling.
Together, they make your environment observable — you’ll know when performance changes or scaling happens.

RESULT:
Your VM Scale Set is now under active watch —
you’ll receive email notifications for high CPU or autoscale events.
=========================================================
'
