# Container & App Platform Oddities in Azure

## Azure Container Apps
- Only supports **Linux containers**.
- No Windows container runtime.
- No GPU support unless you use specific workload profiles.
- Startup time depends heavily on scale rules and revisions.
- Executions happen in a multi-tenant Linux sandbox (Kubernetes + KEDA).

## Azure App Service for Containers
- Linux plans can **only** run Linux container images.
- Windows plans can **only** run Windows images.
- You cannot switch plan type without recreating the App Service Plan.

## Azure Functions
- Different languages support different triggers.
- PowerShell Functions can’t use some bindings supported by C#.
- Cold start varies dramatically by language + plan.
- Durable Functions behave differently per runtime.

## Azure Container Registry (ACR)
- Only **Premium** tier supports Private Endpoints.
- Basic and Standard cannot use firewall + private link together.
- ACR Tasks don’t support Windows containers.

## Azure Kubernetes Service (AKS)
- Windows node pools require a Linux node pool first.
- Windows pods cannot run DaemonSets.
- HostProcess containers only work in Windows pools.

## Container Groups
- Azure Container Instances (ACI) currently supports multi-container groups only for Linux containers
