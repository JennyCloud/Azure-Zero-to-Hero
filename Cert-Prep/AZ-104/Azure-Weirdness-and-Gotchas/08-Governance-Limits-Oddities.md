# Governance, Policies & Limits: The Hidden Rules

## Quotas
- Region-specific resource quotas vary dramatically.
- vCPU quotas apply per VM family.

## Locks
- Cannot override a Delete lock with privileged roles.
- Locks apply at inheritance level unless explicitly broken.
- Resource-level locks don’t block moves.
- Resource group or subscription-level read-only locks do block moves.

## Management Groups
- Cannot move subscriptions across tenants.
- Policy evaluation orders matter for deny/append effects.

## Policy
- Policy cannot be applied to an individual resource from the Azure Portal, however, it can be done via Azure CLI or PowerShell.
