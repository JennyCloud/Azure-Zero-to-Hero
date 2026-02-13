# 🛡️ Web Application Firewall (WAF) – Application Layer Protection in Azure

## 🧠 Concept Overview

A **Web Application Firewall (WAF)** is a security service that protects web applications from common web-based attacks.

It operates at **Layer 7 (Application Layer)** of the OSI model and inspects **HTTP/HTTPS traffic**.

Unlike a traditional firewall that filters based on IPs and ports, a WAF understands:
- URLs
- Headers
- Cookies
- Query strings
- Request bodies

It analyzes web traffic before it reaches your application.

---

## 🎯 What Problems Does WAF Solve?

WAF helps protect against:

- SQL Injection
- Cross-Site Scripting (XSS)
- Command injection
- Cookie poisoning
- Malicious bots
- Common OWASP Top 10 vulnerabilities

It is specifically designed to mitigate application-layer attacks.

---

## ☁️ Microsoft WAF in Azure

In Microsoft Azure, WAF is available with:

- **Azure Application Gateway (WAF v2)**
- **Azure Front Door (WAF policy)**
- **Azure CDN (WAF integration)**

It can run in:
- Detection mode (log only)
- Prevention mode (block malicious traffic)

---

## 🔍 How WAF Works (High-Level Flow)

1. User sends HTTP/HTTPS request
2. Request passes through WAF
3. WAF checks request against:
   - OWASP rule sets
   - Custom rules
4. If malicious:
   - Block request (Prevention mode)
   - Log alert (Detection mode)
5. If clean:
   - Forward to web application

---

## 🔐 WAF vs Traditional Firewall

| Feature | Traditional Firewall | WAF |
|----------|----------------------|------|
| OSI Layer | Layer 3/4 | Layer 7 |
| Filters by | IP, Port, Protocol | HTTP/HTTPS content |
| Protects Against | Network attacks | Web app attacks |
| Example Threat | Port scanning | SQL injection |

---

## 🧩 Key Concepts

- WAF protects **web applications**
- It defends against **OWASP Top 10**
- It operates at **Layer 7**
- It is used with **Application Gateway or Front Door**
- It is NOT the same as Azure Firewall

---

## 🚨 Important Clarification

WAF protects the **application layer**,  
but it does NOT:
- Patch your application
- Replace secure coding practices
- Replace identity protection

It is a protective filter, not a magic shield.

---

## 🧠 One-Line Summary

A **Web Application Firewall (WAF)** is a Layer 7 security service that protects web applications from common HTTP-based attacks such as SQL injection and cross-site scripting.
