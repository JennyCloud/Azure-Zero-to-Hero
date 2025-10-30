# =========================================
# File: autoscale-policy.ps1
# Purpose: Configure an automatic scaling policy for an Azure VM Scale Set
# =========================================

# ---------- Variables ----------
$rg        = "ComputeLab-RG"
$vmssName  = "WebApp-VMSS"
$autoscale = "WebApp-VMSS-AutoScale"
$min       = 1
$max       = 5
$default   = 2

# ---------- Get VMSS Resource ID ----------
$vmss = Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName
$vmssId = $vmss.Id

# ---------- Define Scale Conditions ----------
# 1. Scale OUT when average CPU > 70% for 10 minutes
$scaleOutRule = New-AzAutoscaleRule `
  -MetricName "Percentage CPU" `
  -MetricResourceId $vmssId `
  -Operator GreaterThan `
  -MetricStatistic Average `
  -Threshold 70 `
  -TimeGrain 00:01:00 `
  -TimeWindow 00:10:00 `
  -ScaleActionDirection Increase `
  -ScaleActionValue 1 `
  -ScaleActionCooldown 00:05:00

# 2. Scale IN when average CPU < 30% for 15 minutes
$scaleInRule = New-AzAutoscaleRule `
  -MetricName "Percentage CPU" `
  -MetricResourceId $vmssId `
  -Operator LessThan `
  -MetricStatistic Average `
  -Threshold 30 `
  -TimeGrain 00:01:00 `
  -TimeWindow 00:15:00 `
  -ScaleActionDirection Decrease `
  -ScaleActionValue 1 `
  -ScaleActionCooldown 00:10:00

# ---------- Create the AutoScale Profile ----------
$profile = New-AzAutoscaleProfile `
  -Name "CPU-based-scaling" `
  -Capacity @( $min, $default, $max ) `
  -Rule @( $scaleOutRule, $scaleInRule )

# ---------- Deploy the Autoscale Setting ----------
New-AzAutoscaleSetting `
  -Name $autoscale `
  -ResourceGroupName $rg `
  -TargetResourceId $vmssId `
  -AutoscaleProfile $profile `
  -Enabled $true

# ---------- Verification ----------
Get-AzAutoscaleSetting -ResourceGroupName $rg -Name $autoscale

<#
=========================================================
Explanation:

1. VARIABLES
   - $min, $max, and $default define the scaling limits (1–5 instances).
   - $vmssId identifies the target VM Scale Set.

2. SCALE RULES
   New-AzAutoscaleRule defines conditions that trigger scaling:
     - Scale Out Rule: CPU > 70% for 10 min → add 1 instance.
     - Scale In Rule:  CPU < 30% for 15 min → remove 1 instance.
   TimeGrain = how often metrics are sampled.
   TimeWindow = evaluation period.
   Cooldown = wait time before the next adjustment.

3. PROFILE
   New-AzAutoscaleProfile combines multiple rules and defines capacity bounds.

4. DEPLOYMENT
   New-AzAutoscaleSetting attaches the autoscale configuration to the VMSS.

5. VERIFICATION
   Get-AzAutoscaleSetting confirms that autoscaling is active and lists details.

RESULT:
Your VM Scale Set now grows or shrinks automatically according to real-time CPU usage—
improving efficiency and lowering cost while maintaining performance.
=========================================================
#>
