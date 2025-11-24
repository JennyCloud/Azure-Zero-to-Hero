# Understanding Attribute-Based Access Control (ABAC)

Attribute-Based Access Control (ABAC) is a model in which access is granted based on attributes—facts—about the identity, the resource, or the environment. Instead of granting access through group membership (RBAC), ABAC evaluates rules such as “Allow access when department = Finance AND region = Canada.”

Attributes can include:
- department
- projectCode
- securityClearance
- employmentType
- region
- jobFunction
- deviceTrustLevel
- timeOfDay

ABAC eliminates group sprawl by turning access control into logic-based rules rather than maintaining large group memberships.

ABAC examples:
- Only users with `clearance = gold` can access a secure vault.
- Only users with `region = west` can access west-region data.
- Only contractors with `trainingComplete = yes` can use certain apps.
- Only service principals with `automationRole = backup-runner` can trigger automation.

In Microsoft Entra ID, ABAC works through:
1. Azure Storage ABAC  
2. Azure Key Vault ABAC  
3. Custom applications checking token claims  
4. Service principals and managed identities carrying attributes

Microsoft recently expanded ABAC support by introducing Custom Security Attributes and token claim customization. ABAC is more expressive and scalable than RBAC, especially in large or complex organizations.

RBAC → Who you are (roles and groups)  
ABAC → What describes you (attributes)  
RBAC is simple for small environments.  
ABAC scales better for large environments needing more granular control.
