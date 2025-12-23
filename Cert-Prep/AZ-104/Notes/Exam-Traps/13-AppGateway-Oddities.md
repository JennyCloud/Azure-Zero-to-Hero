# Application Gateway & Front Door Oddities

## Application Gateway
- WAF exclusions only apply to specific rule sets.
- Autoscaling SKU does not auto-scale down instantly.
- Path-based routing breaks if backend health probes fail.

## TLS/SSL
- HTTPS listeners require a certificate; Azure Key Vault integration requires MSI.

## Probes
- You must explicitly configure host headers in probes or health fails.
- Probes ignore NSGs but not routing rules.

## Azure Front Door
- Geo-filtering is WAF-only.
- Front Door Standard/Premium uses different caching rules than Classic.
- Custom domains require TXT validation every time they are re-bound.
