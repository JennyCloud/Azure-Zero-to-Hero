# Governance, Policies & Limits: The Hidden Rules

## Quotas
- Region-specific resource quotas vary dramatically.
- vCPU quotas apply per VM family.

## Locks
- Cannot override a Delete lock with privileged roles.
- Locks apply at inheritance level unless explicitly broken.

## Management Groups
- Cannot move subscriptions across tenants.
- Policy evaluation orders matter for deny/append effects.
