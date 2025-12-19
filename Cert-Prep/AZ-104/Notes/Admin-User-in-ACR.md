# Admin User in Azure Container Registry

The **Admin User** in Azure Container Registry (ACR) is a legacy, convenience-style credential consisting of:

- **One username** (the registry name)
- **Two passwords** (Password1 and Password2)

It provides full access to the entire registry.  
Because this model is insecure by modern standards, Azure disables it by default.

---

## 🛡️ 1. It Bypasses Azure AD Completely

The Admin User does **not** use Azure AD, meaning it has:

- No identity governance  
- No RBAC  
- No Conditional Access  
- No MFA  
- No per-user auditing  

Authentication uses only a static username/password, which is far less secure.

---

## 🤝 2. It Creates Shared Credentials

Everyone using the Admin User shares the same:

- Username  
- Password1/Password2  

Problems this causes:

- No way to know who pushed/deleted images  
- One leaked password compromises the entire registry  
- Password rotation breaks all users at once  

---

## 🔐 3. It Violates Least Privilege

The Admin User always has **full permissions**.  
You cannot limit its access.

Azure AD roles allow proper least privilege, such as:

- `AcrPull`
- `AcrPush`
- `AcrDelete`
- `AcrImageSigner`
- Custom RBAC

These provide far better control and isolation.

---

## 🔄 4. It Conflicts with Modern CI/CD Security

Modern pipelines rely on:

- Managed identities  
- OIDC (federated identity)  
- Short-lived tokens  
- Keyless authentication  

The Admin User uses long-lived passwords stored in secrets → risky.

---

## ⛓️ 5. It Encourages Outdated Auth Practices

The Admin User follows the old Docker model of static credentials.  
Azure prefers:

- `az acr login` using Azure AD  
- Service principals  
- Managed identities for VM, AKS, ACI, Functions, Web Apps  

These are far more secure and automatically rotated.

---

## 🎯 Why Microsoft Still Includes the Admin User

Despite its risks, it's useful for:

- Local testing  
- Quick demos  
- Legacy systems that don't support Azure AD  
- Temporary scenarios  

But it should not be used for production.
