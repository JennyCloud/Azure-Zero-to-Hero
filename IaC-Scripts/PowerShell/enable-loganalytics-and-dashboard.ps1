# =========================================
# File: enable-loganalytics-and-dashboard.ps1
# Purpose: Connect a VM Scale Set to Log Analytics and create a simple dashboard
# =========================================

# ---------- Variables ----------
$rg          = "ComputeLab-RG"
$location    = "CanadaCentral"
$vmssName    = "WebApp-VMSS"
$workspace   = "VMSS-Logs"
$dashboard   = "VMSS-Monitor-Dashboard"

# ---------- Step 1. Create or get Log Analytics Workspace ----------
$ws = Get-AzOperationalInsightsWorkspace -ResourceGroupName $rg -Name $workspace -ErrorAction SilentlyContinue
if (-not $ws) {
    Write-Host "Creating new Log Analytics workspace..." -ForegroundColor Cyan
    $ws = New-AzOperationalInsightsWorkspace -ResourceGroupName $rg -Location $location -Name $workspace -Sku PerGB2018
} else {
    Write-Host "Using existing workspace: $workspace" -ForegroundColor Green
}

# ---------- Step 2. Enable diagnostics for the VM Scale Set ----------
$vmss = Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName
$vmssId = $vmss.Id

Write-Host "Enabling diagnostics (metrics + logs) for $vmssName ..." -ForegroundColor Cyan

Set-AzDiagnosticSetting `
  -Name "VMSS-Diagnostics" `
  -ResourceId $vmssId `
  -WorkspaceId $ws.ResourceId `
  -Enabled $true `
  -Category "AllMetrics"

Write-Host "Diagnostics forwarding enabled to workspace: $workspace" -ForegroundColor Green

# ---------- Step 3. Create a dashboard with metric tiles ----------
$dashboardTemplate = @{
    "$schema" = "https://schema.management.azure.com/schemas/2019-08-01/dashboard.json#"
    "contentVersion" = "1.0.0.0"
    "resources" = @(
        @{
            "type" = "Microsoft.Portal/dashboards"
            "apiVersion" = "2019-01-01-preview"
            "name" = $dashboard
            "location" = $location
            "properties" = @{
                "lenses" = @{
                    "0" = @{
                        "order" = 0
                        "parts" = @{
                            "cpuTile" = @{
                                "position" = @{
                                    "x" = 0; "y" = 0; "colSpan" = 3; "rowSpan" = 4
                                }
                                "metadata" = @{
                                    "inputs" = @(@{ "name" = "ResourceId"; "value" = $vmssId })
                                    "type" = "Extension/MetricsPart"
                                    "settings" = @{
                                        "content" = @{
                                            "chart" = @{
                                                "metrics" = @(
                                                    @{
                                                        "resourceMetadata" = @{}
                                                        "name" = "Percentage CPU"
                                                        "aggregationType" = "Average"
                                                    }
                                                )
                                            }
                                        }
                                        "title" = "VMSS Average CPU"
                                    }
                                }
                            }
                        }
                    }
                }
                "metadata" = @{ "model" = @{ "timeRange" = @{ "value" = "PT1H" } } }
            }
        }
    )
}

Write-Host "Creating Azure Portal dashboard..." -ForegroundColor Cyan
New-AzResourceGroupDeployment -Name "DashboardDeploy" -ResourceGroupName $rg -TemplateObject $dashboardTemplate

Write-Host "Dashboard deployed: $dashboard" -ForegroundColor Green

<#
=========================================================
Explanation:

1. LOG ANALYTICS WORKSPACE
   - Central data store for Azure Monitor logs and metrics.
   - New-AzOperationalInsightsWorkspace creates one if missing.
   - It stores metrics (CPU, memory, network) and platform logs.

2. DIAGNOSTIC SETTINGS
   - Set-AzDiagnosticSetting links your VMSS resource to the workspace.
   - Category "AllMetrics" forwards performance data continuously.

3. DASHBOARD
   - The ARM-style object defines a simple dashboard with a metric tile.
   - The tile shows Average CPU (%) for the VMSS.
   - You can later add more parts: Network In/Out, Disk Read/Write, Instance Count.

4. HOW TO VIEW
   - In Azure Portal: Dashboards → "VMSS-Monitor-Dashboard"
   - Filter time range (last hour/day/week) to analyze load trends.

5. WHY THIS MATTERS
   - Together with alerts and autoscale, this completes the observability loop:
       * Log Analytics = storage and query
       * Alerts = proactive signals
       * Dashboard = visual context

6. NEXT STEPS (optional)
   - Enable VM insights: Enable-AzVMInsights -ResourceId $vmssId -WorkspaceId $ws.ResourceId
   - Query metrics: Get-AzMetric -ResourceId $vmssId
   - Visualize multi-resource dashboards or pin KQL charts from Log Analytics.

RESULT:
Your VMSS now continuously streams metrics to Log Analytics,
and you have a dashboard that displays its performance at a glance.
=========================================================
#>
