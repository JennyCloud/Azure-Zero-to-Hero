# AKS: Oddities, Limitations, and Strange Behaviors

## Node Pools
- A Windows node pool **requires** at least one Linux node pool.
- You cannot run DaemonSets on Windows nodes.
- Windows pods cannot use hostPath volumes.

## Networking
- AKS with Kubenet defaults to SNAT, which can exhaust outbound ports.
- Azure CNI reserves IPs for every pod, even unused ones.
- Inter-pod traffic inside the node may bypass NSGs entirely.

## Upgrades
- Node pool upgrades create new nodes and cordon/drain the old ones.
- Sometimes upgrades hang because of draining a single “stuck” pod.
- Kubernetes version availability varies by region.

## Load Balancing
- Internal LB creation requires specific annotations.
- Standard LB is mandatory for production-grade workloads.

## Container Registry (ACR) Integration
- "ACR Attach" only works if both the AKS and ACR are in the same tenant.
