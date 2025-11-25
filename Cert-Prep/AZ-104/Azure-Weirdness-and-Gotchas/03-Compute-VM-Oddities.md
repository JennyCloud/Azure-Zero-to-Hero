# Compute & VM Oddities

## Ephemeral OS Disks
- Cannot stop/deallocate without losing the OS.
- Extremely fast, but not persistent.
- Great for scaling workloads; bad for stateful servers.

## VM Scale Sets (VMSS)
- Linux VMSS scale faster than Windows VMSS.
- Windows VMSS usually need shutdown scripts for graceful scaling.
- Custom Script Extension behaves differently across OS types.

## Managed Identity Limitations
- User-assigned identities cannot be auto-installed on classic VMs.
- VMSS Flex handles identities differently from VMSS Uniform.

## Site Recovery
- After failover, VM status must be **Failover committed** before reprotection.
- Reprotection flow reverses the replication direction.

## Disk Attachment
- You must **detach** a disk before moving it between VMs.
