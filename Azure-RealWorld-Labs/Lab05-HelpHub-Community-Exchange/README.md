# Lab05 - HelpHub Community Exchange (C#/.NET + SQL + Azure)

**Goal:** Build a community help exchange backend where people can post requests (and later offers), backed by SQL and designed to deploy to Azure with CI/CD.

**Source Code Repo:** https://github.com/JennyCloud/helphub-app

---

## What I built (so far)

### ✅ Backend API (ASP.NET Core .NET 8)
- Versioned REST API routes under `/api/v1`
- Health endpoint for load balancers / uptime checks
- Swagger UI for interactive API testing

### ✅ Database (SQL Server LocalDB) + EF Core
- Code-first data model using Entity Framework Core
- First migration created database + `HelpRequests` table
- API persistence verified end-to-end:
  - POST request → saved to SQL → SELECT query returns row

### ✅ CI (GitHub Actions)
- CI workflow builds the solution on every push/PR to `main`

---

## Architecture (current)

**Today:** Local development stack  
- Client (curl / Swagger)
- ASP.NET Core Web API
- SQL Server LocalDB (HelpHubDb)

**Next (Azure):**  
- Deploy API to Azure compute (App Service or Container Apps)
- Use Azure SQL Database
- CD pipeline via GitHub Actions (OIDC)

---

## API endpoints

| Method | Route | Description |
|---|---|---|
| GET | `/health` | Health check for service monitoring |
| GET | `/api/v1/ping` | Quick smoke test endpoint |
| GET | `/api/v1/help-requests` | List help requests (from SQL) |
| GET | `/api/v1/help-requests/{id}` | Get help request by id |
| POST | `/api/v1/help-requests` | Create a new help request |

---

## Repo links
- App repo: https://github.com/JennyCloud/helphub-app
- Portfolio lab: `Azure-Zero-to-Hero/Azure-RealWorld-Labs/Lab05-HelpHub-Community-Exchange/`
