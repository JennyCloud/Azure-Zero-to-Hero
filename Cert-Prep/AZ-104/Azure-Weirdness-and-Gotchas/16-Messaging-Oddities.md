# Logic Apps, Event Grid, and Messaging Oddities

## Logic Apps
- Standard vs Consumption have totally different architectures.
- Standard requires storage account; Consumption does not.
- VNet integration only works on Standard.

## Event Grid
- Retry policy is mandatory and cannot be disabled.
- Event Grid only sends **event metadata**, not event bodies, for some sources.

## Event Hub
- Consumer groups cannot be deleted if in use.
- Event Hub throughput units cap ingestion; autoscale is not automatic.

## Service Bus
- Sessions are FIFO buckets; session-enabled queues behave like message groups.
- Auto-forwarding chains are limited to 4 hops.
- Duplicate detection only works within a set time frame.
