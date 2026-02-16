# 🔐 Azure Key Vault – Secrets Protection in Microsoft Cloud

## 🧠 Concept Overview

**Azure Key Vault** is a cloud service used to securely store and manage:

- Secrets (passwords, connection strings, API keys)
- Encryption keys
- Certificates

It helps prevent sensitive information from being hard-coded in applications or stored in plain text.

---

## 🎯 Why Azure Key Vault Exists

Applications need secrets to function:
- Database passwords
- Storage account keys
- API tokens
- TLS/SSL certificates

If these are stored in source code or configuration files, they can be exposed.

**Azure Key Vault centralizes and protects these secrets** using strong encryption and access controls.

---

## 🔒 What Azure Key Vault Protects

### 1️⃣ Secrets
Small sensitive values such as:
- Passwords
- Access tokens
- Connection strings

### 2️⃣ Keys
Cryptographic keys used for:
- Data encryption
- Signing
- Key management

### 3️⃣ Certificates
Digital certificates used for:
- HTTPS
- Application authentication
- Secure communication

---

## 🛡️ Security Features

Azure Key Vault provides:

- Role-Based Access Control (RBAC)
- Integration with Microsoft Entra ID
- Logging and monitoring
- Hardware Security Module (HSM) support
- Automatic key rotation (optional)

Access is controlled through **Microsoft Entra ID authentication**, not shared passwords.

---

## 🔄 How It Works in Real Architecture

Instead of:

App → Hard-coded password → Database

You use:

App → Authenticate with Entra ID → Request secret from Key Vault → Access Database

This reduces:
- Secret exposure
- Credential leakage
- Lateral movement risk

---

## 🧩 Relationship to Zero Trust

Azure Key Vault supports Zero Trust by:
- Verifying identity before access
- Enforcing least privilege
- Logging all access attempts
- Eliminating embedded credentials

Never trust hard-coded secrets.

---

## 🏁 One-Line Summary

**Azure Key Vault is a cloud service that securely stores and controls access to secrets, encryption keys, and certificates using Microsoft Entra ID authentication.**
