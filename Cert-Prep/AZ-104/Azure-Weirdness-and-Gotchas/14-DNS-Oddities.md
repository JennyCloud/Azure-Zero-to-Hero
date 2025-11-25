# DNS Service Oddities

## Private Zones
- Cannot link to VNets across tenants.
- Auto-registration works only with specific VM types + NIC settings.

## Alias Records
- Only available for Azure public resources like Traffic Manager, Public IPs.

## TTL Rules
- Azure enforces minimum TTLs on some record types.
- Changes may take 10+ minutes to replicate inside Azure's internal DNS.

## Forwarders
- You cannot create conditional forwarders directly in Azure DNS.
- Must use Azure DNS Private Resolver.
