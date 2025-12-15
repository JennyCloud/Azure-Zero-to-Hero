# Authentication vs Authorization

## Authentication
**Question answered:** “Who are you?”

Authentication is the process of proving identity.  
Examples of authentication mechanisms in Azure Files over SMB:

- NTLM / Kerberos (on-prem AD)
- Azure AD Domain Services Kerberos
- Microsoft Entra Kerberos
- (Not OAuth — SMB doesn’t understand it)

Enabling **Identity-based data access** configures how Azure Files will authenticate SMB clients.  
This is **authentication**, not permission assignment.

**Authentication = identity proof.**

---

## Authorization
**Question answered:** “What are you allowed to do?”

Authorization determines what actions an authenticated user can perform.  
In Azure, this is handled through **RBAC roles**, such as:

- Storage File Data SMB Share Reader  
- Storage File Data SMB Share Contributor  
- Storage File Data SMB Share Elevated Contributor  

These roles are assigned using:

### **Access Control (IAM)**

Assigning a role is **authorization**, not authentication.

**Authorization = permissions.**

---

## Why Azure separates the two
Many Azure services require configuring both authentication and authorization.  
For Azure Files:

- **Authorization** → Assign RBAC role using *IAM*
- **Authentication** → Configure identity-based data access (if using Entra Kerberos for SMB)

---

## Clean mental model

- **Authentication = identity**  
  “Prove you are User1.”

- **Authorization = permission**  
  “User1 is allowed to read/write this share.”

Azure keeps these layers separate so each can be changed independently.
