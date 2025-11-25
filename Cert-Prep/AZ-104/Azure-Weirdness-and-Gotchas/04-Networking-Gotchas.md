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
