# Lab 3 – Azure Virtual Machine Scale Set with Load Balancer

**Author:** Jenny Wang (@JennyCloud)    

---

## 🧠 Overview

This lab extends **Lab 2**, where a public Load Balancer distributed traffic across two standalone VMs.  
Here, I deploy a **Virtual Machine Scale Set (VMSS)** behind the same Load Balancer to achieve automatic scaling and high availability.

**Goal:**  
Create a scalable web tier that automatically provisions IIS on each instance, load-balanced through the existing public endpoint.

**Key Components:**
- Virtual Network: `LB-Lab-VNet`
- Subnet: `WebSubnet`
- Load Balancer: `Web-LB`
- Backend Pool: `LB-Backend`
- Probe: `TCP-Probe`
- Network Security Group: `WebSubnet-NSG`
- VM Scale Set: `WebApp-VMSS-Uniform` (2 instances)

---

## 🏗️ Architecture Diagram

![Lab 3 Architecture Diagram](./lab3-architecture.png)

The Load Balancer receives incoming HTTP requests on port 80 and distributes them across VMSS instances.  
Each instance runs IIS and serves a simple web page that confirms successful setup.

---

## ⚙️ Scripts Used

| Script | Description |
|--------|--------------|
| **create-vmss-lab3.ps1** | Builds the VMSS, links it to the existing Load Balancer, installs IIS using `CustomData`. |
| **fix-loadbalancer.ps1** *(optional)* | Rebuilds or re-links Load Balancer probes and rules if HTTP traffic fails. |
| **verify-vmss.ps1** | Checks that IIS is installed and running across all VMSS instances. |

---
## 🔧 Troubleshooting Guide

| Symptom | Likely Cause | How to Fix |
|----------|---------------|------------|
| **Browser can’t load `http://<PublicIP>`** | The Network Security Group doesn’t allow inbound TCP 80. | Add or verify a rule that allows inbound traffic on port 80:  ```powershell  $rg="LoadBalancer-Lab-RG"; $nsg=Get-AzNetworkSecurityGroup -ResourceGroupName $rg | Where-Object {$_.Name -like "*WebSubnet*"}; $nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80 -Access Allow | Set-AzNetworkSecurityGroup  ``` |
| **Load Balancer probe shows no link to rule** | The load-balancing rule wasn’t associated with the health probe. | Re-associate the probe:  ```powershell  $rg="LoadBalancer-Lab-RG"; $lb=Get-AzLoadBalancer -ResourceGroupName $rg -Name "Web-LB"; $probe=Get-AzLoadBalancerProbeConfig -LoadBalancer $lb -Name "TCP-Probe"; $rule=(Get-AzLoadBalancerRuleConfig -LoadBalancer $lb -Name "HTTP-Rule"); $rule.Probe=$probe; Set-AzLoadBalancer -LoadBalancer $lb  ``` |
| **`W3SVC` service not found / IIS didn’t install** | The VMSS’s CustomData script failed during creation. | Re-run the IIS install script directly on all instances:  ```powershell  Get-AzVmssVM -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" | ForEach-Object {Invoke-AzVmssVMRunCommand -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" -InstanceId $_.InstanceId -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server; Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value "Hello from VMSS instance!"'}  ``` |
| **Load Balancer shows empty backend pool** | The VMSS NICs were never attached to the backend address pool. | Re-attach them:  ```powershell  $rg="LoadBalancer-Lab-RG"; $vmssName="WebApp-VMSS-Uniform"; $lb=Get-AzLoadBalancer -ResourceGroupName $rg -Name "Web-LB"; $backend=Get-AzLoadBalancerBackendAddressPoolConfig -LoadBalancer $lb -Name "LB-Backend"; $vmss=Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName; $vmss.VirtualMachineProfile.NetworkProfile.NetworkInterfaceConfigurations[0].IpConfigurations[0].LoadBalancerBackendAddressPools=@($backend); Update-AzVmss -ResourceGroupName $rg -Name $vmssName -VirtualMachineScaleSet $vmss  ``` |
| **Everything deployed, but HTTP still returns error** | Cached or orphaned LB rule configuration. | Delete and rebuild the load-balancer rule with the correct probe reference (see `fix-loadbalancer.ps1` for the full script). |

> 💡 *Tip:* If nothing works, restart all VMSS instances. Sometimes IIS just needs a friendly reboot.

---

## 🧩 Key Commands

```powershell
# Verify VMSS instance health
Get-AzVmssVM -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" |
Select InstanceId, ProvisioningState, LatestModelApplied

# Check Load Balancer probe configuration
(Get-AzLoadBalancer -ResourceGroupName "LoadBalancer-Lab-RG" -Name "Web-LB").Probes

# Test HTTP connection from Cloud Shell
Invoke-WebRequest http://20.63.9.175 -UseBasicParsing

---

☁️ Lab 3 successfully demonstrates scalable web hosting using Azure VMSS + Load Balancer + NSG automation.


