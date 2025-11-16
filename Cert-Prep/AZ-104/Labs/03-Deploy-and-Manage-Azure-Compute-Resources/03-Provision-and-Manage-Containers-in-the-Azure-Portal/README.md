# Lab 03 - Provision and Manage Containers

This lab demonstrates how to deploy, manage, and scale containers in Azure using several platform services. You will work with Azure Container Registry (ACR), Azure Container Instances (ACI), and Azure Container Apps (ACA) to understand container provisioning, networking, and operational management in preparation for the AZ-104 exam.

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Deploy and manage Azure compute resources (20–25%)**

Provision and manage containers in the Azure portal
- Create and manage an Azure container registry
- Provision a container by using Azure Container Instances
- Provision a container by using Azure Container Apps
- Manage sizing and scaling for containers, including Azure Container Instances and Azure Container Apps

## What Azure Administrators Do in Real Work

Azure administrators treat containers as infrastructure components that need security, networking, identity, predictable scaling, and cost governance. Developers build container images; administrators keep the platform running safely and reliably.

This section explains what Azure admins actually do with **Azure Container Registry (ACR)**, **Azure Container Instances (ACI)**, and **Azure Container Apps (ACA)** in real enterprise environments.

### 1. Manage Azure Container Registry (ACR)

ACR is treated like a secure warehouse for container images. Developers push code; admins keep the warehouse safe and controlled.

#### Admin responsibilities:
- Manage **RBAC roles** such as AcrPull, AcrPush, AcrImageSigner, and custom roles.
- Enforce **private access** using private endpoints and firewall rules.
- Enable image pulls using **Managed Identity** instead of passwords.
- Configure **retention policies** to remove old images and reduce storage costs.
- Monitor **pull failures**, audit logs, and unauthorized access.
- Create **ACR Tasks** for basic image rebuilding workflows.
- Integrate ACR with **GitHub Actions** or **Azure DevOps** pipelines.

#### Admins typically do NOT:
- Write Dockerfiles  
- Build container images  
- Manually push images (except during emergencies)

### 2. Use Azure Container Instances (ACI) for Jobs, Tests, and Quick Deployments

ACI is not commonly used for full production apps. It is mainly a serverless utility tool.

#### Admin responsibilities:
- Run **one-time tasks**, maintenance containers, or automation jobs.
- Create **temporary test containers** for QA or troubleshooting.
- Pull images from ACR to validate builds.
- Set **restart policies** (Always, OnFailure, Never).
- Ensure networking is configured correctly—public or VNET.
- Inject secrets using Key Vault or environment variables.
- Monitor container logs and exit codes.

#### Admins typically do NOT:
- Scale ACI  
- Orchestrate multi-container microservices  
- Host long-running production apps  

ACI acts like a quick, disposable container runner.

### 3. Manage Azure Container Apps (ACA)

ACA is widely used for serverless microservices and scalable API workloads. Admins spend more time here than with ACI.

#### Admin responsibilities:
- Configure **ingress** (internal vs external).
- Set up **autoscaling** using HTTP requests, CPU/memory rules, or KEDA triggers.
- Adjust **min/max replicas** for reliable performance.
- Manage **revision history**, blue/green deployments, and rollbacks.
- Deploy separate **Container App Environments** for dev, test, and prod.
- Configure **Managed Identity** for secure image pulls.
- Store secrets in **Key Vault** and map them to container apps.
- Integrate with **private networks** using VNET integration.
- Monitor logs and metrics via **Log Analytics**.

### 4. Networking Responsibilities

Networking is where most real issues happen, and admins are the ones who fix them.

#### Admin responsibilities:
- Troubleshoot:
  - Failing image pulls  
  - Ingress endpoint unreachable  
  - DNS issues  
  - Internal-only access problems  
- Configure **private DNS zones**.
- Create and manage firewall rules.
- Restrict or allow public access.
- Set up **custom domains** and TLS certificates.
- Lock down environments to internal networks only.

Networking is the backbone of container deployments.

### 5. Identity and Secrets Management

Admins ensure containers operate securely without storing secrets inside images.

#### Admin responsibilities:
- Assign **system or user-managed identities**.
- Grant identity-based pull permissions on ACR.
- Use **Key Vault** for secret injection.
- Rotate keys and certificates.
- Audit secret usage across environments.

### 6. Monitoring and Logging

Monitoring container health and stability is a core admin responsibility.

#### Admin responsibilities:
- Track container restarts and crash loops.
- Monitor CPU/memory usage.
- Watch image pull failures.
- Inspect ingress response times.
- Observe scaling events.
- Configure alerts using Azure Monitor.
- Use Log Analytics and dashboards for aggregated logging.

Admins keep apps stable by watching logs and performance patterns.

### 7. Automation and Infrastructure as Code (IaC)

Production environments rarely rely on portal clicks. Admins automate everything.

#### Common tools:
- **Bicep**
- **Terraform**
- **ARM templates**
- **GitHub Actions**
- **Azure DevOps Pipelines**

#### Admin responsibilities:
- Deploy container environments as code.
- Enforce policies (naming, tags, SKUs).
- Reproduce environments consistently.
- Automatically deploy/update images on new commits.
- Destroy and recreate environments through automation.

The portal is only used for debugging or emergencies.

### 8. Cost Governance

Containers can scale fast, so admins control costs aggressively.

#### Admin responsibilities:
- Set scaling limits to prevent runaway replicas.
- Implement budget alerts.
- Monitor per-environment consumption.
- Select cost-effective SKUs (ACR Basic vs Standard).
- Review unused images or inactive container apps.

Preventing surprise invoices is a priority in real production work.

### Summary

Azure admins:
- Secure container platforms  
- Configure networking and identity  
- Integrate CI/CD  
- Monitor deployments  
- Manage scaling and cost  
- Fix issues when containers misbehave  
- Govern environments using policies and IaC  

Developers build container images.  
Admins ensure they run safely, consistently, and within budget.
