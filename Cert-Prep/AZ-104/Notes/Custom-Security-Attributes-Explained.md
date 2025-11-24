# Custom Security Attributes in Microsoft Entra ID

Custom security attributes are administrator-defined identity attributes that store structured, high-integrity metadata about users, service principals, and managed identities. These attributes are designed for attribute-based access control (ABAC), app logic, and identity-driven automation.

They act as secure, authoritative identity fields that go beyond Entra’s built-in attributes such as department or jobTitle. Organizations can define their own attributes, such as projectCode, clearanceLevel, businessUnitTier, trainingStatus, or regionAccessLevel.

A custom security attribute belongs to an identity that can authenticate and receive a token. This is why they can be assigned to:
- users
- service principals
- managed identities

Groups are not supported because groups do not authenticate, do not receive tokens, and do not carry access claims. Attributes on a group would not appear in a token and would create ambiguous inheritance behavior.

Custom security attributes support:
- structured schema definitions
- restricted allowed values
- delegated administration through attribute sets
- auditing and lifecycle control
- consistent identity claims for tokens and apps

These attributes can flow into:
- OAuth access tokens
- ID tokens
- SAML tokens
- Microsoft Graph responses

Custom security attributes enable ABAC scenarios such as:
- granting access when `research.department = "Genetics"` and `research.classification = "High"`
- allowing automation only when `automation.role = "backup-runner"`
- differentiating app access by region, classification level, or business unit

They help organizations avoid group sprawl and support modern Zero Trust authorization models by providing granular, identity-based metadata for precise access decisions.
