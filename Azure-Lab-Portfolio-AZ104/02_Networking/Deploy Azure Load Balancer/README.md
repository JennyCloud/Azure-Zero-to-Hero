# Lab 2: Azure Load Balancer

![Azure](https://img.shields.io/badge/Azure-Cloud-blue)

## **Objective**
Deploy a **high-availability web application** using two Windows Server 2022 VMs behind a **Standard Azure Public Load Balancer**, demonstrating load balancing, backend pool configuration, and health monitoring.

## **Lab Overview**
- **Resource Group:** `Lab2-LB-RG`  
- **Virtual Network / Subnet:** `Lab2-VNet` / `web-subnet (10.0.0.0/24)`  
- **Virtual Machines:** `WebVM1` & `WebVM2`  
- **Web Server:** IIS installed with custom index pages (`WebVM1`, `WebVM2`)  
- **Load Balancer:** `Lab2-PublicLB` (Standard SKU, public IP)  
- **Backend Pool:** `WebVMs-Pool`  
- **Health Probe:** `HTTP-Probe` (port 80)  
- **Load Balancing Rule:** `HTTP-Rule` (TCP 80)

## **Steps Completed**
1. Created **Resource Group** and **Virtual Network** with subnet.  
2. Deployed two Windows Server 2022 VMs in the subnet.  
3. Installed **IIS** on both VMs and created custom pages.  
4. Configured a **Standard Public Load Balancer**:
   - Added **backend pool** with the two VMs  
   - Configured **health probe** on port 80  
   - Created **load balancing rule** for HTTP traffic  
5. Tested load balancing by accessing the public IP; traffic alternated between the two VMs.

## **Skills Demonstrated**
- Azure Resource Group and VNet management  
- Windows VM deployment and RDP access via Bastion  
- IIS installation and web server configuration  
- Standard Load Balancer deployment, backend pool setup, health probes, and load balancing rules  
- Testing and validating a high-availability web application

## **Outcome**
Successfully deployed a **high-availability web application** on Azure, demonstrating enterprise-level load balancing concepts suitable for AZ-104 and real-world cloud scenarios.

## **Author & Completion Date**
**Author:** Jenny Wang  
**Completed:** October 20, 2025


