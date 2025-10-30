# =========================================
# File: monitoring-and-alerts.ps1
# Purpose: Azure Monitor alerts for a VM Scale Set (VMSS)
# - Creates an Action Group (email + optional webhook)
# - Creates a Metric Alert on VMSS CPU
# - Creates an Activity Log Alert for Autoscale scale actions
# =========================================

# ---------- Variables (edit me) ----------
$rg          = "ComputeLab-RG"
$location    = "CanadaCentral"
$vmssName    = "WebApp-VMSS"

$actionGroupName = "VMSS-ActionGroup"
$actionGroupShort = "vmss-ag"

# Email receiver (change to your email)
$emailName   = "PrimaryEmail"
$emailAddr   = "you@example.com"

# Optional: secure webhook receiver (set to "" to skip)
$webhookName = "ScaleEventsHook"
$webhookUrl  = ""   # e.g., "https://YOURFUNCTIONAPP.azurewebsites.net/api/hook?code=..."

# Metric alert settings
$metricAlertName = "VMSS-CPU-High"
$cpuThreshold    = 80          # percent
$severity        = 3           # 0=Sev0 (critical) ... 4=Sev4 (verbose). 3 ~ Warning
$windowMinutes   = 10          # lookback window
$frequencyMin    = 1           # evaluation frequency

# Activity Log alert settings (fires on Autoscale events)
$activityAlertName = "VMSS-Autoscale-Activity"
# -----------------------------------------

# ---------- Resolve target resource ----------
$vmss   = Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName
$vmssId = $vmss.Id

# ---------- Create Action Group ----------
# Build receivers
$emailRcvr = New-AzActionGroupReceiver `
  -Name $emailName `
  -EmailReceiver `
  -EmailAddress $emailAddr

$receivers = @($emailRcvr)

if ($webhookUrl -and $webhookUrl.Trim().Length -gt 0) {
  $webhookRcvr = New-AzActionGroupReceiver `
    -Name $webhookName `
    -WebhookReceiver `
    -ServiceUri $webhookUrl
  $receivers += $webhookRcvr
}

$actionGroup = New-AzActionGroup `
  -ResourceGroupName $rg `
  -Name $actionGroupName `
  -ShortName $actionGroupShort `
  -Receiver $receivers

Write-Host "Action Group created:" $actionGroup.Id -ForegroundColor Green

# ---------- Create Metric Alert (VMSS CPU > threshold) ----------
$window   = New-TimeSpan -Minutes $windowMinutes
$frequency= New-TimeSpan -Minutes $frequencyMin

# Criteria: Average Percentage CPU > $cpuThreshold
$cpuCriteria = New-AzMetricAlertRuleV2Criteria `
  -MetricName "Percentage CPU" `
  -TimeAggregation Average `
  -Operator GreaterThan `
  -Threshold $cpuThreshold

$metricAlert = New-AzMetricAlertRuleV2 `
  -Name $metricAlertName `
  -ResourceGroupName $rg `
  -WindowSize $window `
  -Frequency $frequency `
  -TargetResourceId $vmssId `
  -Severity $severity `
  -Condition $cpuCriteria `
  -ActionGroupId $actionGroup.Id `
  -AutoMitigate `
  -Description "Warn when VMSS CPU is high (>${cpuThreshold}% average for ${windowMinutes} min)."

Write-Host "Metric Alert created:" $metricAlert.Name -ForegroundColor Green

# ---------- Create Activity Log Alert (Autoscale scale actions) ----------
# We alert when Category == 'Autoscale'
# Tip: use Get-AzActivityLog to inspect real event fields in your tenant.
$condGroup = New-AzActivityLogAlertConditionGroup `
  -Field "category" -EqualTo "Autoscale"

$activityAlert = New-AzActivityLogAlert `
  -Name $activityAlertName `
  -ResourceGroupName $rg `
  -Location $location `
  -Scope $vmssId `
  -Condition $condGroup `
  -ActionGroupId $actionGroup.Id `
  -Description "Notify when Autoscale scales the VMSS in or out."

Write-Host "Activity Log Alert created:" $activityAlert.Name -ForegroundColor Green

# ---------- Output handy summary ----------
Write-Host "`nSummary:" -ForegroundColor Cyan
Write-Host "  Action Group:       $($actionGroup.Name)"
Write-Host "  Metric Alert:       $($metricAlert.Name)  (CPU>${cpuThreshold}% | Sev$severity)"
Write-Host "  Activity Log Alert: $($activityAlert.Name)  (Category=Autoscale)"
Write-Host "  Target VMSS:        $vmssName"
Write-Host ""

<#
=========================================================
Explanation (what each block does and why):

ACTION GROUP
  - Think of an Action Group as your "who to notify" list. It can include:
      * Email receivers
      * Webhook/Function receivers
      * SMS, Voice, ITSM, Logic Apps, etc. (supported by Azure Monitor)
  - We create one reusable Action Group and attach it to multiple alerts.

METRIC ALERT (VMSS CPU)
  - New-AzMetricAlertRuleV2 evaluates a metric on a target (your VMSS).
  - We alert when Average "Percentage CPU" > $cpuThreshold
    across a $windowMinutes-minute window, evaluated every $frequencyMin minutes.
  - -Severity 3 marks this as a Warning-level alert.
  - -AutoMitigate allows Azure to automatically resolve the alert
    when the condition returns to normal.

ACTIVITY LOG ALERT (Autoscale)
  - Autoscale emits Activity Log events whenever it scales in/out.
  - We alert on Activity Log entries where category == "Autoscale".
  - This is complementary to the metric alert; you’ll know *when* scaling occurred,
    not just that CPU was high.

ABOUT "LIMITING NOTIFICATION NOISE"
  - Use reasonable windows/frequencies (10-min window, 1-min checks) to avoid flapping.
  - Consider Azure "Action Rules" (a.k.a. Alert Processing Rules) to suppress or
    schedule mute windows (e.g., nights/weekends or burst suppression).
    * In PowerShell, look for cmdlets like New-AzAlertProcessingRule* (module updates vary).
    * In the Portal: Azure Monitor > Alerts > Processing rules.
  - You can also adjust -Severity and route only Sev0–Sev2 to on-call channels.

TESTING TIPS
  - To test CPU alerts, deploy a simple CPU loader on one instance and watch the alert fire.
  - To test Autoscale alerts, temporarily lower the autoscale-out threshold,
    generate load, and confirm an Activity Log alert is sent.

SECURITY NOTE
  - If you use a webhook/Function URL, treat it as a secret. Don’t commit it to public repos.
  - Use Key Vault or environment variables to inject it securely in CI/CD.

RESULT
  You now have signal (metrics) + narrative (activity) + responders (action group).
  That’s the classic observability triangle for production-friendly environments.
=========================================================
#>
