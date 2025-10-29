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
| Issue                                                                                                                                                | Cause                             | Fix                                                                           |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- | ----------------------------------------------------------------------------- |
| **HTTP page not loading**                                                                                                                            | NSG doesn’t allow inbound port 80 | Add an inbound rule for TCP port 80 in `WebSubnet-NSG`.                       |
| **Probe not showing linked to rule**                                                                                                                 | Rule missing probe reference      | Use `fix-loadbalancer.ps1` to rebuild the load-balancing rule with probe ID.  |
| **“W3SVC service not found” error**                                                                                                                  | IIS didn’t install correctly      | Run `Install-WindowsFeature -Name Web-Server` manually on each VMSS instance. |
| **No backend IPs in Load Balancer**                                                                                                                  | VMSS not linked to backend pool   | Reattach using PowerShell:                                                    |
| `$vmss.VirtualMachineProfile.NetworkProfile.NetworkInterfaceConfigurations[0].IpConfigurations[0].LoadBalancerBackendAddressPools = @($backendPool)` |                                   |                                                                               |
| `Update-AzVmss -ResourceGroupName "LoadBalancer-Lab-RG" -Name "WebApp-VMSS-Uniform" -VirtualMachineScaleSet $vmss`                                   |                                   |                                                                               |

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


