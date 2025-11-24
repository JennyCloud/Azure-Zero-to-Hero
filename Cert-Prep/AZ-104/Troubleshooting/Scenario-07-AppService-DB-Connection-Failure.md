# Troubleshooting Scenario #7 — Azure App Service can’t connect to a database

## Situation
You deploy a Web App (Azure App Service).  
The app tries to connect to:

- Azure SQL  
- Azure MySQL  
- Azure PostgreSQL  
- SQL Server on a VM  
- Cosmos DB  
- or a private database behind a VNet  

…but the app throws errors like:

- “Cannot connect to server”  
- “Timeout expired”  
- “Network-related or instance-specific error”  
- “Login failed”  
- “Client with IP X.X.X.X is not allowed”  

This is one of the most important real-world AZ-104 scenarios because App Service networking behaves differently from VM networking.

---

## How to think about it

App Service connectivity depends on four layers:

1. **Outbound IP(s)**  
2. **Firewall of database**  
3. **VNet integration (if used)**  
4. **DNS resolution**  

App Services don’t sit in your VNet by default, and they don’t have a single outbound IP — they have a *set* of IPs.

If any part of this chain breaks, the app can’t reach the DB.

---

## Most common causes

### 1. Database firewall not allowing the App Service outbound IPs
Every App Service has **multiple outbound IPs** (up to 7+).

For Azure SQL / MySQL / PostgreSQL, you must allow:

- ALL outbound IPs  
- OR use VNet integration + private endpoint  

If you only add ONE IP you saw in an error log → database still blocks the rest.

Classic AZ-104 trap.

---

### 2. App Service is using VNet integration incorrectly
If you enable **VNet Integration**, outbound traffic goes through:

- The VNet  
- NSGs  
- Route tables  

If your VNet has:

- A UDR that sends 0.0.0.0/0 → NVA  
- A firewall blocking traffic  
- A private endpoint incorrectly configured  

…the App Service loses access to the DB.

“VNet Integration” = “Your app now inherits your network problems.”

---

### 3. DNS resolution failure
If you integrate into a VNet that uses:

- A custom DNS server  
- An unreachable DNS server  
- A DNS forwarder missing Azure zones  

…the Web App cannot resolve:

- `*.database.windows.net`  
- `*.privatelink.database.windows.net`  
- VM hostnames  

DNS failure = instant connection failure.

---

### 4. Wrong connection string
Even small mistakes matter:

- Missing `Encrypt=True` (Azure SQL requires it)  
- Using `localhost` instead of server name  
- Using HTTP URL instead of SQL endpoint  
- Using private link endpoint without VNet integration  

This is surprisingly common.

---

### 5. Private endpoint but no VNet integration
If your database uses **Private Endpoint**, then:

- App Services **must** use **VNet Integration** to reach it  
- Otherwise all traffic from the App tries public access → blocked  

This is one of the biggest points of confusion for learners.

---

## How to solve it — the admin sequence

### Step 1 — Check the App Service outbound IP address list
App → Properties → Outbound IP Addresses

If DB firewall only has *one* of these → problem.

Add all outbound IPs OR move to VNet + private endpoint.

---

### Step 2 — If using VNet integration, check effective routes
App → Networking → VNet Integration → Route table

Look for:

- `0.0.0.0/0 → Virtual appliance`  
- `0.0.0.0/0 → None`  
- Missing routes to database subnet  

If outbound is misrouted, App Service cannot reach the DB.

---

### Step 3 — Check database firewall
Azure SQL → Networking

Look for:

- Allowed client IPs  
- Allow Azure services access (might help for testing)  
- Private endpoint connections  

If using MySQL/PostgreSQL Flexible Server:

- Public access: Allowed VNet/subnet?  
- Private access: Private endpoint connected?

---

### Step 4 — Test DNS resolution
From Kudu Console:

nslookup <your-database-server>.database.windows.net


If DNS fails → fix VNet DNS, forwarders, or private DNS zones.

---

### Step 5 — Check connection string
Make sure the string includes:

- Correct server FQDN  
- Correct database name  
- Username@servername (for Azure SQL)  
- Encrypt=True  
- TrustServerCertificate=False  

Wrong connection string = guaranteed failure.

---

## Why follow these steps?

App Service connectivity is different from VM connectivity, so you diagnose in the order Azure uses:

1. **Outbound IP list** — Azure chooses ANY of these  
2. **Firewall** — database allows or rejects  
3. **VNet integration routing** — if enabled, it overrides everything  
4. **DNS resolution** — app cannot connect to what it cannot resolve  
5. **Connection string** — final leg, must match exact format

Checking in any other order causes headaches:

- Fixing firewall won’t help if outbound IPs are missing  
- Fixing DNS won’t help if routing is broken  
- Fixing connection string won’t help if DB firewall blocks App Service  
- Fixing VNet rules won’t help if you're not using VNet integration at all  

This sequence mirrors the **actual connection journey** used by the App Service runtime.
