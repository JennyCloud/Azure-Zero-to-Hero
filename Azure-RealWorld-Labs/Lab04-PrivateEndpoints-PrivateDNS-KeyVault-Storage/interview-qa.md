# Lab04 – Interview Q&A  
## Private Endpoints & Private DNS (Storage & Key Vault)

This document contains common **Azure interview questions** and **practical answers** based on Lab04.  

---

## Q1. Why do you need Private Endpoints if you already disabled public network access?

**Answer:**  
Disabling public network access only blocks traffic from the internet.  
Private Endpoints are still required to provide a **private IP address inside the VNet** so workloads can reach the service.

Without a Private Endpoint:
- Public access is disabled
- DNS still resolves to public endpoints
- Applications cannot connect at all

Private Endpoints provide the **actual private entry point**.

---

## Q2. What problem does Private DNS solve in this design?

**Answer:**  
Private DNS ensures that **standard service FQDNs** (for example, `storageaccount.blob.core.windows.net`) resolve to **private IPs** instead of public ones.

Without Private DNS:
- DNS resolves to public endpoints
- Traffic fails when public access is disabled
- Developers may incorrectly hardcode IPs (bad practice)

Private DNS allows applications to work **without code changes**.

---

## Q3. How do you confirm traffic is actually private?

**Answer:**  
You must verify **runtime behavior**, not just configuration.

From a VM inside the VNet:
- `nslookup` should return a **10.x.x.x** address
- HTTPS requests should succeed (200 / 403 / 401)

In this lab, verification was done using:
- `az vm run-command`
- No SSH, no public IPs

---

## Q4. Why is a 403 or 401 response considered a success during verification?

**Answer:**  
Because the goal is **network reachability**, not authorization.

- 401 / 403 means:
  - DNS resolution worked
  - Network path is correct
  - HTTPS traffic reached the service

Authorization failures are expected without credentials and **prove the network is working**.

---

## Q5. Why use `az vm run-command` instead of SSH or RDP?

**Answer:**  
`az vm run-command`:
- Requires **no inbound ports**
- Works without public IPs
- Is auditable and scriptable
- Matches real enterprise security practices

In locked-down environments, SSH/RDP is often disabled entirely.

---

## Q6. Why does the Private Endpoint need to be in a separate subnet?

**Answer:**  
Azure requires **network policies to be disabled** on Private Endpoint subnets.

Separating subnets:
- Prevents accidental NSG or UDR interference
- Matches Microsoft best practices
- Makes troubleshooting clearer

This design avoids hidden connectivity issues.

---

## Q7. What happens if the Private DNS zone is not linked to the VNet?

**Answer:**  
DNS resolution falls back to public endpoints.

Symptoms:
- `nslookup` returns public IPs
- Traffic fails when public access is disabled
- Applications appear “broken” despite Private Endpoints existing

This is one of the **most common real-world misconfigurations**.

---

## Q8. Why is Azure RBAC used for Key Vault instead of access policies?

**Answer:**  
Azure RBAC:
- Is consistent with other Azure services
- Supports centralized identity governance
- Works better with PIM and role assignments
- Is the recommended modern approach

Access policies are legacy and harder to manage at scale.

---

## Q9. What would break if someone enabled public network access later?

**Answer:**  
Security posture would be weakened:
- Services become reachable from the internet
- Attack surface increases
- Compliance requirements may be violated

However, functionality would still work — which is why **policy enforcement** is often added in real environments.

---

## Q10. How would you scale this design in an enterprise environment?

**Answer:**  
Common extensions include:
- Centralized Private DNS in a hub subscription
- Hub-and-spoke VNets
- Azure Policy to enforce private-only access
- Central logging and monitoring
- Multiple Private Endpoints per service (multi-region)

This lab represents the **building block** of those designs.

---

## Q11. What are common troubleshooting steps if connectivity fails?

**Answer:**  
1. Check DNS resolution inside the VNet
2. Confirm Private Endpoint approval status
3. Verify correct Private DNS zone linkage
4. Ensure subnet policies are disabled
5. Confirm public access is actually disabled (expected)

Most issues are **DNS-related**, not networking.

---

## Q12. Why is this design considered “production-ready”?

**Answer:**  
Because it:
- Uses Infrastructure as Code
- Avoids public exposure
- Follows least-privilege access
- Separates network concerns cleanly
- Supports automation and auditing

This is the same pattern used in **regulated and enterprise environments**.
