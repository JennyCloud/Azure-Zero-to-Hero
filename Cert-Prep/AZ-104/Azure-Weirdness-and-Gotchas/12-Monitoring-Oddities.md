# Monitoring & Observability Oddities

## Log Analytics
- Workspaces cannot be moved across regions.
- Retention > 30 days requires extra cost.
- Table plan (Basic/Analytics) affects ingestion and query cost.

## Azure Monitor Metrics
- Some metrics are 1-minute granularity, others 30 seconds, others 5 minutes.
- Not all metrics support alerts.

## Diagnostic Settings
- Sending logs to Event Hub has different schemas from Log Analytics.
- Some resources have incomplete diagnostic categories.

## VM Insights
- Requires two agents (AMA + Dependency Agent).
- Dependency Agent is being deprecated, causing data gaps.

## Azure Alerts
- Multi-resource alerts only work for some metric types.
