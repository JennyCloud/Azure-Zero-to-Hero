# Lab 01 - Configure and Manage Virtual Networks

## Overview


## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Implement and manage virtual networking (15–20%)**

Configure and manage virtual networks in Azure
- Create and configure virtual networks and subnets
- Create and configure virtual network peering
- Configure public IP addresses
- Configure user-defined network routes
- Troubleshoot network connectivity

## Special Notes
### We Need Two Directions to Peer Two VNets
Azure VNet peering always consists of **two peering entries**, one on each VNet:
- `vnet-hub01 → vnet-spoke01`
- `vnet-spoke01 → vnet-hub01`
Each VNet keeps its own settings (traffic allowed, forwarded traffic, gateway use).  
Because these settings are independent, both sides must explicitly agree.
If only one side exists, peering shows **Initiated/Disconnected** and traffic won’t flow.
Even when using PowerShell/CLI to create both at once, Azure still creates **two** objects under the hood.

## What Azure Administrators Do in Real Work
