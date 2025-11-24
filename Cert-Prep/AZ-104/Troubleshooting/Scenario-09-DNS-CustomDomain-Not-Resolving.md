
or open the site in a browser…

It **does not resolve** or points to the wrong IP.

This is one of the most common Azure DNS exam scenarios because DNS depends on two worlds talking to each other:

**Azure DNS** + **External domain registrar**.

If they don’t connect → the world cannot find your domain.

---

## How to think about it

Creating a DNS zone in Azure does *not* automatically make the world use it.

You must tell your domain registrar:

> “Use Azure as my DNS authority.”

If you skip this, all your Azure DNS records work only **inside Azure**, not on the public internet.

This is the #1 failure path.

---

## Most common causes

### 1. Registrar name servers not updated to Azure DNS
When you create an Azure DNS zone, Azure gives you **four name servers**, like:

ns1-07.azure-dns.com
ns2-07.azure-dns.net
ns3-07.azure-dns.org
ns4-07.azure-dns.info


You MUST copy these into your domain registrar (GoDaddy, Namecheap, Cloudflare, Google Domains, etc.).

If you don’t → the public internet still uses the registrar’s DNS servers, not Azure’s.

This is the most common reason domains “don’t work.”

---

### 2. DNS records added in Azure, but propagated name servers are wrong
You might have:

- Mixed name servers from different DNS providers  
- Old values cached at the registrar  
- Partial NS updates  

If the registrar shows different name servers from Azure → the world ignores Azure’s zone.

---

### 3. You created the wrong record type
Examples:

- You add an A record but your App Service expects a CNAME  
- You added a CNAME but the root domain (`contoso.com`) *must* use A records  
- You pointed to the wrong IP (staging slot, old LB IP, etc.)  

Azure DNS will accept anything — but external resolution will fail.

---

### 4. TTL caching delays
DNS has TTL (time to live).  
If old values were cached for:

- 5 minutes  
- 1 hour  
- 1 day  

The world may still be resolving the old records.

This causes the classic:

> “It works for me but not for others.”

---

### 5. You created a subdomain in Azure but didn’t delegate it
Example:

You want:

`api.contoso.com`

But the parent zone `contoso.com` is NOT hosted in Azure.

You MUST configure **NS delegation** from the parent zone to the Azure child zone.

Without that → the child zone is invisible.

---

## How to solve it — the admin sequence

### Step 1 — Check if the registrar points to Azure DNS
Go to your registrar and verify the name servers match exactly:

ns1-xx.azure-dns.com
ns2-xx.azure-dns.net
ns3-xx.azure-dns.org
ns4-xx.azure-dns.info


If these don't match → nothing else matters.

---

### Step 2 — Use `nslookup` or `dig` to check public resolution
Test from the internet:

nslookup www.contoso.com


If it resolves to registrar DNS → Azure DNS is not being used.

---

### Step 3 — Confirm DNS records exist in Azure DNS
Azure Portal → DNS Zones → contoso.com → Records

Verify:

- A record has the correct public IP  
- CNAME matches your App Service domain  
- TXT records exist for verification  
- No typos in names (common mistake: extra period, extra www)

---

### Step 4 — If using a subdomain zone, check NS delegation
Example:

Azure zone: `api.contoso.com`  
Parent zone: `contoso.com` (in GoDaddy)

You MUST add NS records in **contoso.com** that point to the NS servers of **api.contoso.com**.

---

### Step 5 — Wait for DNS propagation
TTL may take from 5 minutes to several hours depending on previous values.

To confirm propagation:

nslookup www.contoso.com 8.8.8.8
nslookup www.contoso.com 1.1.1.1
nslookup www.contoso.com 9.9.9.9


If each returns the same IP, propagation is complete.

---

## Why follow these steps?

DNS fails for only a few reasons, and the sequence reflects the public DNS resolution path:

1. **Does the world use Azure DNS?** (registrar → Azure name servers)  
2. **Does Azure DNS have the correct records?**  
3. **Does your record type match your service?**  
4. **Is this a subdomain needing delegation?**  
5. **Has the world updated its DNS cache yet?**  

If you check these out of order:

- You may debug Azure DNS when the registrar is still using old servers  
- You may fix records that the world will never see  
- You may check propagation even though you used the wrong NS servers  
- You may troubleshoot App Service when the issue is DNS, not the app  

DNS is hierarchical — so troubleshooting must follow the hierarchy.
