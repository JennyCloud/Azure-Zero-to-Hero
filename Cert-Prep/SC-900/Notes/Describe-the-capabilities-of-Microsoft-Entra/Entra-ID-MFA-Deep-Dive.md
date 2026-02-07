# Microsoft Entra ID: Authentication & MFA Reference Guide

This document covers the primary Multi-Factor Authentication (MFA) methods available in Microsoft Entra ID (formerly Azure AD), focusing on their functionality, security levels, and hardware requirements.

---

## 1. Core MFA Methods (Any Device)
In Microsoft Entra ID, certain methods are prioritized because they are highly accessible across different hardware platforms and provide a complete authentication solution.

* **Microsoft Authenticator App:** * **Type:** Software-based.
    * **Capabilities:** Supports push notifications, Time-based One-Time Passwords (TOTP), and passwordless sign-in.
    * **Benefit:** Highly secure and works on any modern iOS or Android device.
* **Voice Call:** * **Type:** Telephony-based.
    * **Capabilities:** User receives an automated call and presses `#` to authenticate.
    * **Benefit:** Universal compatibility; requires only a standard phone line.



---

## 2. FIDO2 Security Keys
FIDO2 keys are considered the "Gold Standard" for modern authentication due to their resistance to phishing.

### How They Work
FIDO2 keys use **Public Key Cryptography**. During registration, a unique key pair is created:
1.  **Public Key:** Stored by Microsoft Entra ID.
2.  **Private Key:** Stored securely inside the physical hardware (e.g., a YubiKey).



### Key Benefits
* **Phishing Resistant:** The key is cryptographically bound to the specific website. It will not work on a fraudulent/spoofed login page.
* **Passwordless Experience:** Users can sign in using only the security key and a local PIN/Biometric.
* **Offline Capability:** The key does not require an internet connection or cellular signal to generate its response.

---

## 3. OATH Hardware Tokens
OATH (Open Authentication) tokens are physical devices that generate a 6-digit code.

* **Function:** They use a time-based algorithm (TOTP) synchronized with the Entra ID server.
* **Use Case:** Ideal for high-security environments where smartphones are prohibited (e.g., government labs or secure manufacturing floors).
* **Limitation:** Unlike FIDO2, OATH codes can be manually intercepted or phished by a sophisticated attacker.



---

## 4. Comparison Table

| Feature | OATH Hardware Tokens | FIDO2 Security Keys | Authenticator App |
| :--- | :--- | :--- | :--- |
| **Primary Method** | 6-Digit Code (TOTP) | Public Key Crypto | Push / TOTP |
| **Phishing Resistance** | Low | **High** | Medium |
| **Passwordless** | No | **Yes** | Yes (Phone Sign-in) |
| **Hardware Required** | Key Fob | USB/NFC Key | Smartphone |
| **Setup Complexity** | Manual (CSV Upload) | Self-Service | Self-Service |

---

## 5. Implementation Summary
For most organizations, the recommended path is to move users toward **Passwordless** methods:
1.  **High Privilege Accounts (Admins):** FIDO2 Security Keys.
2.  **Standard Users:** Microsoft Authenticator App (Push Notifications).
3.  **Backup/Legacy:** SMS or Voice Call (though these are the least secure).

> **Note:** Biometric methods like **Face Recognition** and **Fingerprint Recognition** (via Windows Hello for Business) are hardware-dependent and bound to a specific device, unlike the "any device" portability of the Authenticator app or FIDO2 keys.
