# Azure Key Vault: Behaviors You Don't Expect

## Access Policies vs RBAC
- You cannot mix RBAC mode and Access Policy mode.
- Switching modes resets access.

## Secret Rotation
- Secrets do NOT auto-rotate unless you attach a rotation policy (only supported for certain resources).
- Keys rotate differently than secrets.

## Soft Delete
- Key Vault has mandatory soft-delete; retention is 7–90 days.
- Cannot disable soft delete since 2022.

## Networking
- Private endpoints disable public access ONLY if firewall rules are configured.
- Access may break for VMs using outdated DNS forwarders.

## Certificates
- Importing PFX works; exporting private keys does not unless explicitly marked.
