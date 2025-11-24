# Troubleshooting Scenario #15 — Azure AD (Entra ID): User cannot sign in due to Conditional Access or MFA failures

## Situation
A user reports:

- “I can’t sign in.”  
- “Microsoft says my sign-in is blocked.”  
- “Requires MFA but I can’t complete it.”  
- “This device doesn’t meet your compliance requirements.”  
- “Sign-in blocked due to Conditional Access policy.”  

In the Admin Portal, sign-in logs show:

- **Failure**  
- **Blocked sign-in**  
- **MFA required but not satisfied**  
- **Conditional Access failure**  
- **Sign-in interrupted**

This is a classic AZ-104 identity troubleshooting scenario because Conditional Access, MFA, device compliance, and location rules often intersect.

---

## How to think about it

Every Azure AD sign-in must pass:

1. **Authentication** (password / token)  
2. **MFA** (if required)  
3. **Conditional Access evaluation**  
4. **Device compliance checks** (Intune)  
5. **Location/network requirements**  
6. **App type restrictions**

If any step fails → the user is blocked.

---

## Most common causes

### 1. Conditional Access policy blocks the user
Policies may require:

- MFA  
- Hybrid-joined/compliant device  
- Sign-in only from specific countries  
- Modern authentication only  
- Approved client apps  

If the user doesn't meet conditions → blocked.

---

### 2. User is required to do MFA but never registered
MFA may be required by:

- Security defaults  
- Conditional Access  
- Tenant-wide MFA settings  

But user has **no MFA methods** registered.

---

### 3. User lost MFA device
Common issues:

- Phone lost  
- Authenticator removed  
- Number changed  
- Factory reset wiped Authenticator app  

Logs show: “MFA required” → “failed to satisfy.”

---

### 4. Device compliance requirement fails
If CA requires:

- Compliant device  
- Hybrid join  
- App protection policies  

…but user's device is:

- Not enrolled  
- Not compliant  
- Using non-approved app  

→ Blocked.

---

### 5. Legacy authentication blocked
If CA blocks legacy auth, user apps like:

- Older Outlook  
- IMAP/POP  
- Old Office  
- Older PowerShell modules  

…will fail.

---

### 6. Named locations restrictions
Example:

- “Allow Canada only.”  
- “Block risky countries.”  

User signs in from:

- VPN  
- Travel  
- Public Wi-Fi  

→ Blocked.

---

### 7. Account locked or disabled
User may have:

- Expired password  
- Disabled account  
- High-risk sign-in automatically blocked  

---

## How to solve it — admin sequence

### Step 1 — Check Sign-in Logs
Azure AD → **Sign-in Logs**

Check:

- Failure reason  
- Conditional Access result  
- MFA status  
- Device state  
- Client app type  

---

### Step 2 — Identify which Conditional Access policy applied
In the Sign-in Logs:

- Open the sign-in event  
- Scroll to “**Conditional Access**”  
- Look for which policy shows **Failure**

This is the real cause.

---

### Step 3 — Fix MFA issues
If MFA is required but cannot be satisfied:

- Reset the user’s MFA registration  
- Allow them to re-register  
- Temporarily exclude from MFA-required CA policy  

---

### Step 4 — Fix device compliance
If CA requires compliant or hybrid-joined devices:

- Enroll device in Intune  
- Fix compliance issues  
- Remove or modify the CA requirement  
- Temporarily allow “All devices”  

---

### Step 5 — Adjust location restrictions
If CA blocks the user's location:

- Add new trusted location  
- Modify the restriction  
- Temporarily exclude user from the policy  

---

### Step 6 — Fix legacy authentication issues
If policy blocks legacy protocols:

- Upgrade Outlook / apps  
- Use modern authentication clients  
- Switch from POP/IMAP to Exchange Online modern auth  

---

### Step 7 — Reset password or unlock account
If sign-in failures relate to:

- Password expiration  
- Risky sign-in  
- Admin lockout  

Reset password and re-test.

---

### Step 8 — Re-test sign-in
Have user sign in again, and recheck sign-in logs to confirm the issue is resolved.

---

## Why follow these steps?

Azure AD sign-ins depend on this pipeline:

1. **Authentication** → Is password/token valid?  
2. **MFA** → Is MFA required and satisfied?  
3. **Conditional Access** → Does the policy permit access?  
4. **Device compliance** → Is device approved?  
5. **Location rules** → Is user allowed from this region?  
6. **App restrictions** → Is the client app allowed?  

Troubleshooting out of order causes confusion:

- Fixing MFA won’t help if CA blocks the device  
- Fixing CA won’t help if user uses legacy auth  
- Fixing password won’t help if location restriction blocks sign-in  
- Fixing device won’t help if MFA is missing  

You always start from the **Sign-in Logs**, then follow the pipeline step-by-step.

