# Networking Gotchas

## Load Balancers
- Standard LB requires NSGs for traffic to pass.
- Health probe configuration directly affects distribution.
- Five-tuple hash gives best distribution but not always required.

## DNS
- Private DNS zones are not shareable across tenants without workarounds.
- Alias records only work with specific Azure resource types.

## VNet/Subnet Rules
- VM cannot directly connect to multiple subnets without multiple NICs.
- A NIC belongs to exactly one subnet.

## Private Endpoints
- ACR requires Premium tier for private endpoints.
- Storage private endpoints sometimes require special DNS zones:
  - privatelink.blob.core.windows.net
  - privatelink.file.core.windows.net

## Routing
- BGP routes override system routes.
- User-defined routes override system routes unless blocked by NSGs.

## Azure Firewall
- The Azure Firewall and virtual network must be in the same resource group and same region.
- The public IP address (associated with the firewall) can be in a different resource group.
- Resources: https://learn.microsoft.com/en-us/azure/firewall/firewall-faq#are-there-any-firewall-resource-group-restrictions

## Bastion
Azure Bastion tunnels RDP sessions over port 443, eliminating the need to open port 3389 in the NSG.

Bastion is a security-sensitive, region-bound, gateway-style service.
Its public IP must therefore be:
- Standard → locked-down edge network behavior
- IPv4 → current bastion control-plane requirement
- Regional → matches the region of the Bastion host
- Static → stable endpoint for security, auditing, and enterprise firewalls
