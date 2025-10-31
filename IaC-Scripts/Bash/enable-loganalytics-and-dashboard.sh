#!/bin/bash
# =========================================
# File: enable-loganalytics-and-dashboard.sh
# Purpose: Connect VMSS to Log Analytics and create a simple dashboard
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"
vmssName="WebApp-VMSS"
workspaceName="VMSS-Logs"
dashboardName="VMSS-Monitor-Dashboard"

# ---------- Step 1. Create or Retrieve Log Analytics Workspace ----------
echo "Checking for Log Analytics workspace '$workspaceName'..."
workspaceId=$(az monitor log-analytics workspace show \
  --resource-group "$rgName" \
  --workspace-name "$workspaceName" \
  --query id -o tsv 2>/dev/null)

if [ -z "$workspaceId" ]; then
  echo "Workspace not found. Creating new workspace..."
  workspaceId=$(az monitor log-analytics workspace create \
    --resource-group "$rgName" \
    --workspace-name "$workspaceName" \
    --location "$location" \
    --sku PerGB2018 \
    --query id -o tsv)
else
  echo "Using existing workspace: $workspaceId"
fi

# ---------- Step 2. Enable Diagnostic Settings ----------
echo ""
echo "Enabling diagnostics for VMSS '$vmssName'..."
az monitor diagnostic-settings create \
  --name "VMSS-Diagnostics" \
  --resource "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$rgName/providers/Microsoft.Compute/virtualMachineScaleSets/$vmssName" \
  --workspace "$workspaceId" \
  --metrics '[{"category": "AllMetrics","enabled": true}]' \
  --output none

echo "Diagnostics forwarding to Log Analytics enabled."

# ---------- Step 3. Create Dashboard (ARM template style) ----------
echo ""
echo "Creating Azure Portal dashboard '$dashboardName'..."

cat > dashboard.json <<EOF
{
  "\$schema": "https://schema.management.azure.com/schemas/2019-08-01/dashboard.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Portal/dashboards",
      "apiVersion": "2019-01-01-preview",
      "name": "$dashboardName",
      "location": "$location",
      "properties": {
        "lenses": {
          "0": {
            "order": 0,
            "parts": {
              "cpuTile": {
                "position": { "x": 0, "y": 0, "colSpan": 3, "rowSpan": 4 },
                "metadata": {
                  "inputs": [
                    { "name": "ResourceId", "value": "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$rgName/providers/Microsoft.Compute/virtualMachineScaleSets/$vmssName" }
                  ],
                  "type": "Extension/MetricsPart",
                  "settings": {
                    "content": {
                      "chart": {
                        "metrics": [
                          { "name": "Percentage CPU", "aggregationType": "Average" }
                        ]
                      }
                    },
                    "title": "VMSS Average CPU"
                  }
                }
              }
            }
          }
        },
        "metadata": { "model": { "timeRange": { "value": "PT1H" } } }
      }
    }
  ]
}
EOF

az deployment group create \
  --name "DashboardDeploy" \
  --resource-group "$rgName" \
  --template-file dashboard.json \
  --output table

rm dashboard.json

echo "✅ Dashboard '$dashboardName' created successfully."
echo "View it in Azure Portal → Dashboards."

: '
=========================================================
Explanation:

1. LOG ANALYTICS WORKSPACE
   - Stores metrics and logs for long-term analysis.
   - The script checks for an existing workspace and reuses it if found.

2. DIAGNOSTIC SETTINGS
   - "az monitor diagnostic-settings create" forwards VMSS metrics to Log Analytics.
   - Category "AllMetrics" captures CPU, memory, disk, and network statistics.

3. DASHBOARD
   - The dashboard.json object defines a single CPU chart tile.
   - It’s deployed as an ARM resource with az deployment group create.
   - You can later add more tiles (Network In/Out, Disk IO, Instance Count).

4. CLEANUP
   - Temporary dashboard.json is deleted after deployment.

5. RESULT
   - View your dashboard in the Azure Portal under Dashboards → "VMSS-Monitor-Dashboard".

🧭 Key Takeaways
Log Analytics = centralized log and metric repository for Azure Monitor.
Diagnostic Settings connect resources (like VMSS) to your workspace.
Dashboards are ARM resources — portable and version-controlled JSON templates.
This approach gives you persistent visibility even if VMs scale in/out dynamically.

=========================================================
'
