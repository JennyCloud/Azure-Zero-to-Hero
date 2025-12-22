# Lab05 – HelpHub (Community Help Exchange Backend)

## Overview
**HelpHub** is a real-world style backend service that enables community members to post and retrieve help requests (e.g. moving help, tutoring, errands).

This lab focuses on **building, deploying, and automating** a production-style .NET backend on **Microsoft Azure**, using **Infrastructure as Code (Bicep)** and **GitHub Actions (OIDC)**.

The API is **live on Azure**, backed by **Azure SQL**, and deployed automatically via **CI/CD**.

## Source Code

Application repository:  
https://github.com/JennyCloud/helphub-app

---

## Real-World Scenario
Community platforms often need:
- A simple REST API
- Persistent storage
- Secure cloud deployment
- Automated build & deployment pipelines

This lab simulates how a small SaaS or community platform backend would be built and shipped in a real engineering environment.

---

## Tech Stack

- **Language / Framework:** C# / .NET 8 Web API
- **ORM:** Entity Framework Core (Code-First)
- **Database:** Azure SQL Database
- **Hosting:** Azure App Service (Basic B1)
- **IaC:** Bicep
- **CI/CD:** GitHub Actions (OIDC authentication)

---

## API Endpoints

### Health & Diagnostics
| Method | Endpoint | Description |
|------|---------|-------------|
| GET | `/health` | Health check for App Service |
| GET | `/api/v1/ping` | Connectivity test |

### Help Requests
| Method | Endpoint | Description |
|------|---------|-------------|
| GET | `/api/v1/help-requests` | List all help requests |
| GET | `/api/v1/help-requests/{id}` | Get a single request |
| POST | `/api/v1/help-requests` | Create a help request |

---

## Database Design

**Table:** `HelpRequests`

| Column | Type |
|------|------|
| Id | uniqueidentifier (PK) |
| Title | nvarchar(200) |
| Location | nvarchar(120) |
| Status | nvarchar(20) |
| CreatedUtc | datetimeoffset |

- Schema created using **EF Core migrations**
- Same migration applied locally and to **Azure SQL**

---

## Infrastructure as Code (Bicep)

Provisioned resources include:
- Resource Group (Canada Central)
- App Service Plan (B1)
- Azure Web App
- Azure SQL Server + Database
- SQL firewall rules (Azure services only)

All infrastructure is defined and deployed using **Bicep**.

---

## CI/CD Pipeline

### Continuous Integration (CI)
- Triggered on every push to `main`
- Restores and builds the solution
- Fails fast on compile errors

### Continuous Deployment (CD)
- Triggered on API changes
- Uses **GitHub OIDC → Azure Entra ID**
- No stored Azure secrets
- Automatically deploys to Azure App Service

---

## Key Learnings

- Building a production-ready .NET backend
- Using EF Core consistently across environments
- Secure Azure deployments using **OIDC**
- Infrastructure-as-Code with Bicep
- Debugging cloud + database issues end-to-end

---

## Next Steps

Potential extensions:
- Authentication & authorization (JWT / Entra ID)
- Frontend (Blazor / React)
- Containerization (Docker + Container Apps)
- Managed Identity for Azure SQL
- Observability (Application Insights)
