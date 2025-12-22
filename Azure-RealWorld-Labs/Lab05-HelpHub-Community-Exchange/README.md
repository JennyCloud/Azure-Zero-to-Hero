# Lab05 - HelpHub Community Exchange (C#/.NET + SQL + Azure)

**Goal:** Build a community help exchange backend where people can post requests (and later offers), backed by SQL and designed for deployment to Azure with CI/CD.

**Source Code Repo:**  
https://github.com/JennyCloud/helphub-app

---

## What I built (so far)

### ✅ Backend API (ASP.NET Core .NET 8)
- Versioned REST API routes under `/api/v1`
- Health endpoint for load balancers and uptime checks
- Swagger UI for interactive API testing and exploration

### ✅ Database (SQL Server LocalDB) + EF Core
- Code-first data model using Entity Framework Core
- Initial migration created the database and `HelpRequests` table
- End-to-end persistence verified:
  - POST request → saved to SQL → SELECT query returns the row

### ✅ CI (GitHub Actions)
- GitHub Actions workflow that builds the solution on every push or pull request to `main`

---

## Architecture (current)

### Today: Local development stack
- Client: curl / Swagger UI  
- Backend: ASP.NET Core Web API  
- Database: SQL Server LocalDB (`HelpHubDb`)

### Next: Azure deployment
- Deploy API to Azure compute (App Service or Container Apps)
- Replace LocalDB with Azure SQL Database
- Add CD pipeline using GitHub Actions with OIDC authentication

---

## API Endpoints

| Method | Route | Description |
|------|------|-------------|
| GET | `/health` | Health check endpoint for service monitoring |
| GET | `/api/v1/ping` | Lightweight smoke-test endpoint |
| GET | `/api/v1/help-requests` | List all help requests (from SQL) |
| GET | `/api/v1/help-requests/{id}` | Retrieve a help request by ID |
| POST | `/api/v1/help-requests` | Create a new help request |
