# 🕵️ Insider Risk Management

## 🧠 Concept Overview

**Insider Risk Management (IRM)** is a Microsoft Purview solution that helps organizations 
identify, investigate, and act on risky behavior performed by trusted users.

An "insider" is not necessarily malicious. It can include:

- Employees
- Contractors
- Partners
- Anyone with legitimate access to organizational data

The risk comes from how access is used — not from breaking in.

---

## 🔎 What Problems Does It Address?

Insider Risk Management helps detect:

- Data leaks
- Data theft
- Intellectual property theft
- Policy violations
- Security policy circumvention
- Risky behavior before employee departure

It uses signals from:
- Microsoft 365 activity
- Endpoint activity
- Azure AD (Microsoft Entra ID)
- Microsoft Defender

---

## ⚙️ How It Works (High-Level Flow)

1. **Policies are created**
   - Example: Data exfiltration policy
   - Example: Departing employee risk policy

2. **Risk indicators are monitored**
   - Large file downloads
   - Uploading files to personal cloud storage
   - Copying files to USB
   - Accessing unusual amounts of sensitive data

3. **Risk scoring is calculated**
   - AI and machine learning assign risk levels

4. **Alerts and cases are generated**
   - Security teams investigate
   - Actions can be taken (escalation, HR review, etc.)

---

## 🧬 Key Characteristics

- Uses **machine learning and behavioral analytics**
- Privacy-focused (role-based access and anonymization by default)
- Built into **Microsoft Purview compliance portal**
- Supports regulatory compliance investigations

---

## 🔐 Important Points

- Insider Risk Management is part of **Microsoft Purview**
- It focuses on **internal user risk**, not external attacks
- It relies on **signals and behavioral patterns**
- It is proactive — not just reactive
- Privacy controls are built in

---

## 🎯 One-Line Summary

**Insider Risk Management helps organizations detect, investigate, and respond to risky behavior performed by internal users using behavioral analytics and risk scoring.**
