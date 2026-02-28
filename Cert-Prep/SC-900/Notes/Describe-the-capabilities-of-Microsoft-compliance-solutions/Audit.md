# 📜 Audit Logging in Microsoft Security (SC-900)

## 🧠 Concept Overview

**Audit logging** is the process of recording activities and events within a system.

In Microsoft cloud environments, audit logs track:
- Who signed in
- What changes were made
- When the activity occurred
- Where the activity came from (IP/location)
- Whether the action succeeded or failed

Audit logs help organizations:
- Detect suspicious activity
- Investigate incidents
- Meet compliance requirements
- Maintain accountability

Without auditing, security becomes guesswork.

---

## 🔎 What Gets Audited?

Examples of auditable activities:

- User sign-ins
- Role assignments (e.g., Global Administrator added)
- File access and sharing
- Policy changes
- Application consent changes
- Security setting modifications

If something changes in the environment, audit logs can record it.

---

## 🛠️ Microsoft Tools That Provide Auditing

### 🔐 Microsoft Entra ID
- Sign-in logs
- Audit logs (user, group, role, policy changes)
- Conditional Access reporting

### 🛡️ Microsoft 365 Compliance Center
- Unified Audit Log
- Tracks activity across:
  - Exchange Online
  - SharePoint Online
  - OneDrive
  - Teams

### 🚨 Microsoft Defender
- Security alerts
- Incident timelines
- Threat investigation logs

---

## 🎯 Why Audit Matters in SC-900

Audit logging supports:

- 🔍 **Detection** — Identify unusual behavior
- 🧾 **Compliance** — Meet regulatory requirements (e.g., data protection laws)
- 🧠 **Forensics** — Investigate security incidents
- 👤 **Accountability** — Track privileged activity

Many SC-900 questions test whether you understand:
- Logs help detect threats
- Logs support investigations
- Logs are required for compliance

---

## 🧩 Important Insight

> Audit logs do not prevent attacks.
> They help detect, investigate, and respond to them.

Audit is about visibility, not protection.

---

## 🏛️ Relationship to Zero Trust

Zero Trust assumes breach.

Audit logs:
- Verify identities continuously
- Monitor privileged access
- Provide evidence of abnormal behavior

Zero Trust without auditing is like security without memory.

---

## 🧠 One-Line Summary

**Audit logging records and tracks activities in Microsoft cloud services to support security monitoring, compliance, and incident investigation.**
