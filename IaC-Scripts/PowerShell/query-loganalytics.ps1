# =========================================
# File: query-loganalytics.ps1
# Purpose: Run KQL queries from PowerShell against a Log Analytics workspace
# =========================================

# ---------- Variables ----------
$rg        = "ComputeLab-RG"
$workspace = "VMSS-Logs"
$queryName = "AverageCPUQuery"

# ---------- Step 1. Get Workspace Info ----------
$ws = Get-AzOperationalInsightsWorkspace -ResourceGroupName $rg -Name $workspace

# ---------- Step 2. Define a KQL Query ----------
# This query retrieves the average CPU for each VMSS instance in the last hour.
$kql = @"
Perf
| where ObjectName == "Processor" and CounterName == "% Processor Time"
| summarize AvgCPU = avg(CounterValue) by Computer
| sort by AvgCPU desc
"@

# ---------- Step 3. Run the Query ----------
Write-Host "Running KQL query against Log Analytics workspace..." -ForegroundColor Cyan
$results = Invoke-AzOperationalInsightsQuery -WorkspaceId $ws.CustomerId -Query $kql

# ---------- Step 4. Display the Results ----------
Write-Host "`nQuery Results: Average CPU by VMSS Instance" -ForegroundColor Green
$results.Results | Format-Table -AutoSize

<#
=========================================================
Explanation:

1. KQL (Kusto Query Language)
   - Query language used by Azure Monitor, Log Analytics, Application Insights.
   - Similar to SQL but optimized for large log and metric datasets.
   - Pipes (|) chain operations (filter, summarize, project, sort).

2. QUERY
   - Table: Perf → stores performance metrics.
   - Filter: where ObjectName == "Processor"
             and CounterName == "% Processor Time"
   - summarize avg(CounterValue) by Computer
     → groups by VM name (Computer) and computes average CPU.
   - sort by AvgCPU desc → highest CPU first.

3. INVOKE-AZOPERATIONALINSIGHTSQUERY
   - Executes the KQL query directly from PowerShell.
   - Returns a table of results in $results.Results.

4. PRACTICAL USES
   - Replace Perf with other tables, e.g.:
       AzureMetrics
       Heartbeat
       AzureActivity
   - Example: count scale actions from Autoscale events
       AzureActivity
       | where Category == "Autoscale"
       | summarize Count = count() by bin(TimeGenerated, 1h)

5. WHY IT'S USEFUL
   - KQL gives you analytical depth that dashboards or alerts can’t:
       “Show me hourly CPU trend per instance.”
       “List which nodes scaled the most this week.”
       “Find failed requests grouped by region.”

RESULT:
This script connects your PowerShell automation with Azure Monitor analytics.
You can mix automation (deployments) and investigation (queries)
in a single workflow—perfect for troubleshooting or capacity planning.
=========================================================
#>
