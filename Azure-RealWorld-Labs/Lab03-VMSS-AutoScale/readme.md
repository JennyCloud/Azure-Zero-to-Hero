# 🌐 Lab 3 – Azure Virtual Machine Scale Set (VMSS) with Load Balancer

## 🧠 Overview

This lab extends **Lab 2**, where a public Load Balancer distributed traffic across two standalone VMs.  
In **Lab 3**, a **Virtual Machine Scale Set (VMSS)** replaces those VMs to provide **automatic scaling**, **high availability**, and **simplified management** — all behind the same load balancer.

**🎯 Goal:**  
Deploy a scalable web tier that automatically installs IIS on each instance and balances web traffic through the existing public endpoint.

### Key Components
- **Virtual Network:** `LB-Lab-VNet`  
- **Subnet:** `WebSubnet`  
- **Load Balancer:** `Web-LB`  
- **Backend Pool:** `LB-Backend`  
- **Health Probe:** `TCP-Probe`  
- **Network Security Group:** `WebSubnet-NSG`  
- **VM Scale Set:** `WebApp-VMSS-Uniform` (2 instances)

---

## 🏗️ Architecture Diagram

**Traffic Flow:**  
1. Client sends an HTTP request to the public IP.  
2. The Load Balancer routes traffic via **port 80** to VMSS instances.  
3. Each instance runs **IIS** and serves a simple web page confirming success.  

---

## ⚙️ Scripts Used

| Script | Purpose |
|:--------|:---------|
| **`create-vmss-lab3.ps1`** | Builds the VM Scale Set, links it to the existing Load Balancer, and installs IIS via `CustomData`. |

---

## 🔧 Troubleshooting Guide

| Symptom | Likely Cause | How to Fix |
|:---------|:-------------|:------------|
| **Browser can’t load `http://<PublicIP>`** | NSG doesn’t allow inbound TCP 80. | Allow HTTP traffic:<br>```powershell<br>$rg="LoadBalancer-Lab-RG"<br>$nsg=Get-AzNetworkSecurityGroup -ResourceGroupName $rg \| Where-Object {$_.Name -like "*WebSubnet*"}<br>$nsg \| Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80 -Access Allow \| Set-AzNetworkSecurityGroup<br>``` |
| **Load Balancer probe not linked** | Rule not associated with the health probe. | Re-associate:<br>```powershell<br>$rg="LoadBalancer-Lab-RG"<br>$lb=Get-AzLoadBalancer -ResourceGroupName $rg -Name "Web-LB"<br>$probe=Get-AzLoadBalancerProbeConfig -LoadBalancer $lb -Name "TCP-Probe"<br>$rule=Get-AzLoadBalancerRuleConfig -LoadBalancer $lb -Name "HTTP-Rule"<br>$rule.Probe=$probe<br>Set-AzLoadBalancer -LoadBalancer $lb<br>``` |
| **IIS not installed / `W3SVC` missing** | `CustomData` script failed during creation. | Re-run IIS install on all instances:<br>```powershell<br>Get-AzVmssVM -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" \| ForEach-Object {<br>  Invoke-AzVmssVMRunCommand -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" -InstanceId $_.InstanceId -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server; Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value "Hello from VMSS instance!"'<br>}<br>``` |
| **Backend pool empty** | VMSS NICs not attached to backend pool. | Re-attach:<br>```powershell<br>$rg="LoadBalancer-Lab-RG"<br>$vmssName="WebApp-VMSS-Uniform"<br>$lb=Get-AzLoadBalancer -ResourceGroupName $rg -Name "Web-LB"<br>$backend=Get-AzLoadBalancerBackendAddressPoolConfig -LoadBalancer $lb -Name "LB-Backend"<br>$vmss=Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName<br>$vmss.VirtualMachineProfile.NetworkProfile.NetworkInterfaceConfigurations[0].IpConfigurations[0].LoadBalancerBackendAddressPools=@($backend)<br>Update-AzVmss -ResourceGroupName $rg -Name $vmssName -VirtualMachineScaleSet $vmss<br>``` |
| **HTTP error persists after deployment** | Cached or orphaned LB rule. | Delete and rebuild the rule (see `fix-loadbalancer.ps1`). |

> 💡 **Tip:** If all else fails, restart VMSS instances — sometimes IIS just needs a friendly reboot.

---

## 🏁 Summary

This lab demonstrates how to:
- Deploy a **VM Scale Set** for high availability and elasticity.  
- Integrate it seamlessly with an **existing Load Balancer**.  
- Automate **IIS installation** via `CustomData` during provisioning.  
- Validate and troubleshoot backend connectivity using **PowerShell and Azure tools**.

By completing this lab, I gain hands-on experience with **auto-scaling web tiers**, a crucial skill for cloud administrators and DevOps engineers.
