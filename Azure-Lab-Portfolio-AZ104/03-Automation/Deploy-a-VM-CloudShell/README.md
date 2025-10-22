# Lab 3: Deploy a VM using Cloud Shell

---

## Objective
Deploy a Windows Server 2019 VM in Azure using Cloud Shell, configure secure access via Azure Bastion, and test network connectivity.

---

## Lab Overview
- **Resource Group:** RG-Test-Bastion-Central  
- **Virtual Network / Subnet:** TestVMVNet / default subnet  
- **Virtual Machine:** TestVM (Windows Server 2019)  
- **Bastion Host:** BastionHost (Standard Public IP)  
- **Access Method:** RDP via Azure Bastion  
- **Connectivity Test:** Internet access verified from VM using PowerShell

---

## Steps Completed
1. Created a new resource group (`RG-Test-Bastion-Central`) in `centralus`.  
2. Deployed a Windows Server 2019 VM (`TestVM`) using Cloud Shell.  
3. Created a Bastion subnet (`AzureBastionSubnet`) in the VM’s VNet.  
4. Deployed a public IP (`BastionPublicIP`) for the Bastion host.  
5. Created and configured Bastion host (`BastionHost`) for secure RDP access.  
6. Connected to the VM via Bastion and verified access.  
7. Tested network connectivity from inside the VM using `Test-NetConnection` and `ping`.

---

## Skills Demonstrated
- Azure Resource Group and VNet management  
- Windows VM deployment using Cloud Shell  
- Azure Bastion deployment and secure RDP access  
- Testing network connectivity from a VM  
- Troubleshooting region and VM size availability issues

---

## Outcome
Successfully deployed a Windows VM in Azure, configured secure Bastion access, and verified connectivity, demonstrating essential cloud deployment and secure access skills suitable for AZ-104 and real-world scenarios.

---

## Author & Completion Date
**Author:** Jenny Wang  
**Completed:** October 22, 2025
