# Private Endpoint: Hidden Behaviors & DNS Puzzles

## DNS Chaos
- You MUST use specific private DNS zones:
  - privatelink.blob.core.windows.net
  - privatelink.file.core.windows.net
  - privatelink.vaultcore.azure.net
- Without DNS, the Private Endpoint exists but is useless.

## Breaking Public Connectivity
- Enabling a Private Endpoint doesn't disable public access.
- You need firewall rules or service endpoints to fully lock it down.

## Storage Accounts
- Blob, File, Queue, Table each need their own DNS zone.
- Private endpoint for blob does NOT cover file shares.

## Key Vault
- Access may break after adding a private endpoint if your VM uses older DNS.

## Multiple VNets
- Private endpoints cannot be shared across VNets without DNS forwarding.
