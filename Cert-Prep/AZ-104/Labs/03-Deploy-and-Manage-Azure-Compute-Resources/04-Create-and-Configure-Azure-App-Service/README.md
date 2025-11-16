# Lab 04 – Create and Configure Azure App Service

Azure App Service is basically “Platform-as-a-Service for web apps.” We don’t manage the VM OS, patching, scaling mechanisms, or load balancers. The platform does it. The lab covers everything an admin is expected to touch: plans, scaling, TLS, DNS, backups, networking, and deployment slots.

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Deploy and manage Azure compute resources (20–25%)**

Create and configure Azure App Service
- Provision an App Service plan
- Configure scaling for an App Service plan
- Create an App Service
- Configure certificates and Transport Layer Security (TLS) for an App Service
- Map an existing custom DNS name to an App Service
- Configure backup for an App Service
- Configure networking settings for an App Service
- Configure deployment slots for an App Service

## What Azure Administrators Really Do with App Services

### 1. Treat App Service Plans like shared apartments
In real environments, an App Service Plan (ASP) is rarely created for a single tiny app unless it’s mission-critical. ASP is billed by the hour regardless of number of apps inside.

Admins constantly balance:  
- “Do we isolate this app for security/privacy reasons?”  
- “Do we consolidate apps to save cost?”  
- “Is this S1 plan enough, or did the devs deploy a CPU hog again?”

Admins also watch for "noisy neighbour" situations — one app eating all CPU across the shared plan.

### 2. Autoscale isn't optional — it's survival
Traffic rarely behaves predictably. Apps get hammered at odd times. Admins set autoscale rules not because it’s fancy, but because it's cheaper than outages.

Typical real rules:  
- CPU > 70% for 15 mins → add instance  
- HTTP queue length > 100 → add instance  
- Scale down slowly to prevent oscillation  
- Cool-down periods to avoid ping-pong scaling  

Admin brain:  
“Never trust marketing when they say traffic will be stable.”

### 3. Identity and secrets always move to Key Vault
Production apps almost never store secrets in App Service configurations.

Real flow:  
- Create Key Vault  
- Put connection strings there  
- App Service gets Key Vault references  
- Enforce Managed Identity-only access  

Admins don't want 3am calls saying “someone leaked an appsettings.json.”

### 4. Custom domains + certificates are constant maintenance
Domains expire. Certificates expire. DNS changes break sites.  
Admins deal with:

- Rotating certificates (even managed ones sometimes fail to auto-renew if DNS is misconfigured)  
- Fixing “domain not verified” errors after someone edits the DNS records  
- Monitoring for near-expiry certs  
- Wildcard cert requests for multi-tenant apps  

This is the part where admins age faster.
#### Admins Repeat the Subdomain Process Monthly

A subdomain seems tiny — just a new DNS name, right?  
But in real organizations, new subdomains = new business ideas.

Marketing launches a new event → `event.company.com`  
Customer success wants a portal → `portal.company.com`  
Developers want a feature preview → `beta.company.com`  
Security team isolates an area → `secure.company.com`  
Product wants regional rollouts → `eu.company.com`, `apac.company.com`  

Every department sees subdomains as cheap, harmless expansions.  
But each one requires:

- DNS creation  
- Verification  
- Binding to App Service  
- TLS certificate creation  
- Certificate renewal  
- Occasionally moving the mapping during redesigns  

This is why admins repeat it monthly: business evolves faster than anyone can document, and DNS becomes the front-line evidence of that evolution.

DNS is like the naming ceremony for every new idea.

### 5. Backups + Restore testing
Admins don't just “turn on backups.” They:

- Store backups in a separate storage account (different region preferred)  
- Schedule automatic backups  
- Run disaster recovery drills:  
  “Pretend the app is dead. Restore it. Time it.”  
- Keep infra-as-code so restores recreate settings too  

Production = trust nothing until tested.

### 6. Networking is where things get real
Most production App Services:

- Integrate with a VNet  
- Connect privately to SQL servers via Private Endpoints  
- Use Access Restrictions to block public access  
- Put WAF-enabled Application Gateway or Front Door in front of the app  

Admins don’t like public inbound traffic hitting apps directly.  
Everything goes behind a “shield”—Application Gateway or Front Door.

### 7. Deployment slots are not optional
Direct deployment to production is for small labs, not real companies.

Real-world deployment flow:  
- Dev pushes code → CI/CD pipeline builds → deploy to staging slot  
- Tests run: smoke tests, API checks, health checks  
- If green → swap staging → production  
- If red → cancel swap → staging roll-back  

Admins love slots because outages drop dramatically.

### 8. Monitoring is the heartbeat of admin life
Admins monitor App Services like a hawk:

- Application Insights for slow requests  
- Failed requests count  
- Memory leaks  
- 500 and 503 spikes  
- Dependency graph  
- Logs analysis queries  
- Alerts tied to Teams/Slack/PagerDuty  

When an outage happens, 80% of the job is reading charts and playing detective.

### 9. Security, security, security
Admins constantly enforce:

- TLS 1.2 or higher  
- HTTPS-only  
- Disable FTP  
- Disable SCM public access  
- MSI-based access  
- Rotate secrets/keys  
- Scan containers for vulnerabilities  
- Ensure logs are retained for X days  

Every misconfiguration is potential downtime.

In short:  
Azure App Service is easy to deploy but tricky to operate.  
Admins spend more time automating, monitoring, securing, scaling, and recovering than they do “creating the app.”
