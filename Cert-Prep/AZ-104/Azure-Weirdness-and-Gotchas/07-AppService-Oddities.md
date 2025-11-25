# App Service Oddities

## Plan Types
- Windows and Linux plans are not interchangeable.
- You cannot “convert” plans—you must recreate.

## Scaling
- Scale-out rules differ between OS types.
- Linux containers occasionally restart during infrastructure updates.

## File System
- App Service uses a shared network-mounted filesystem for Linux plans.
- Not suitable for performance-heavy I/O workloads.

## Networking
- VNet integration behaves differently between Windows and Linux.
- Regional VNet integration is not the same as Gateway-required VNet integration.
