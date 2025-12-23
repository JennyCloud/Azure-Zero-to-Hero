# IaC (Bicep/ARM) Oddities

## Copy Loops
- You cannot use `copy` loops inside variables in ARM templates.
- Loops inside properties behave differently between Bicep and ARM.

## Conditions
- Conditional resources must include all required properties, even if skipped.

## DependsOn
- Bicep auto-manages dependencies, but ARM requires explicit `dependsOn`.
- Cyclic dependencies error silently with confusing messages.

## Parameters
- SecureString parameters cannot be exported from ARM exports.
- You cannot output SecureStrings.

## Template Export
- Exported templates often include dynamic values, not reusable patterns.
- VM exports do not include extensions unless specifically deployed.
