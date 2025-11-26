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

## Bastion Public IP Requirements
Bastion is a security-sensitive, region-bound, gateway-style service.
Its public IP must therefore be:
- Standard → locked-down edge network behavior
- IPv4 → current bastion control-plane requirement
- Regional → matches the region of the Bastion host
- Static → stable endpoint for security, auditing, and enterprise firewalls
