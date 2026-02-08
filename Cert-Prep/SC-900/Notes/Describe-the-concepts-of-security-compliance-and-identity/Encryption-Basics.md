# 🔐 Encryption Basics in Microsoft Cloud

## 🧠 Concept Overview

**Encryption** is the process of converting readable data (**plaintext**) into an unreadable format (**ciphertext**) using a mathematical algorithm and a **cryptographic key**.

Only someone with the **correct key** can decrypt the data and read it.

In the Microsoft cloud, encryption is a **foundational security control** used to protect data from:
- Unauthorized access
- Data theft
- Accidental exposure

---

## 🔑 Core Encryption Concepts

### Plaintext vs Ciphertext
- **Plaintext:** Human-readable data (emails, files, database records)
- **Ciphertext:** Encrypted data that appears random and unreadable

---

### Encryption Keys
An **encryption key** is a string of data used by an algorithm to encrypt and decrypt information.

- If you **have the key**, you can read the data
- If you **don’t have the key**, the data is useless noise

Protecting the **key** is just as important as protecting the data.

---

## 🔐 Types of Encryption

### 🔁 Symmetric Encryption
- Uses **one single key** for both encryption and decryption
- Fast and efficient
- Commonly used for **data at rest**

**Example:** AES (Advanced Encryption Standard)

---

### 🔀 Asymmetric Encryption
- Uses a **key pair**:
  - Public key (encrypt)
  - Private key (decrypt)
- Slower but more flexible
- Commonly used for **secure communication**

**Example:** RSA

---

## 📦 Encryption in the Cloud

### 🧊 Encryption at Rest
Protects data **stored on disk**.

**Examples:**
- Azure Storage encryption
- Azure SQL Database encryption

➡️ Data is encrypted automatically using strong algorithms (like AES-256).

---

### 🌐 Encryption in Transit
Protects data **moving across networks**.

**Examples:**
- HTTPS
- TLS (Transport Layer Security)

➡️ Prevents attackers from reading or altering data in transit.

---

## 🧑‍🔐 Who Manages the Keys?

### Microsoft-Managed Keys
- Default option
- Microsoft creates, stores, and rotates keys
- Least administrative effort

---

### Customer-Managed Keys (CMK)
- Customer controls the encryption keys
- Keys stored in **Azure Key Vault**
- Required for stricter compliance scenarios

➡️ More control, more responsibility.

---

## 🎯 Why Encryption Matters

- Protects **confidentiality** of data
- Supports **compliance requirements**
- Reduces impact of data breaches
- Closely tied to:
  - Zero Trust
  - Data protection
  - Identity and access management

---

## 🧩 One-Line Summary

**Encryption protects data by converting it into an unreadable format using cryptographic keys, ensuring confidentiality both at rest and in transit.**
