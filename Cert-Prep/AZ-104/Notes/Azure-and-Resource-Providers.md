# Azure and Resource Providers

## Azure as the Big City  
Think of Azure as a massive, bustling city. Every major service—Key Vault, Storage, Virtual Machines, SQL, Web Apps—is run by its own department.  
These departments are called **resource providers**.

A resource provider is a service-specific engine inside Azure that knows:

- how to create its own resources  
- how to validate configurations  
- what values are allowed  
- how to enforce minimum requirements  
- how to respond to deployment requests  

Azure is the mayor’s office.  
Resource providers are the specialized departments:

- Microsoft.Storage  
- Microsoft.Compute  
- Microsoft.KeyVault  
- Microsoft.Web  
- Microsoft.Network  

Each one owns its own resource types.

---

## Clear Mental Model

Picture Azure as an airport.  
Each airline at the airport has its own rules.

- **Azure = the airport**  
- **Resource provider = the airline**  
- **A Storage Account = a plane belonging to the Storage airline**

Azure governs things like identity, RBAC, policy, and billing.  
Resource providers govern the technical rules for their own services.

---

## How They Interact During Deployment

When you deploy a resource:

1. The request enters ARM (Azure Resource Manager).  
2. ARM checks:  
   - Do you have permission?  
   - Do any Azure Policies apply?  
3. ARM hands off the request to the correct resource provider.  
4. The resource provider decides:  
   - Is the configuration valid?  
   - Is this value allowed?  
   - Is this SKU supported?  
   - Is the API version valid?  
   - Should the request be rejected?

ARM is the gatekeeper.  
Resource providers are the builders that actually construct the resource.

---

## A Simple Example

If you deploy a configuration that sets a minimum TLS version that is not allowed, Azure Policy may not block it, but the Microsoft.Storage provider will reject it with a validation error.  
This happens even if there is no policy preventing it.

This shows how the platform (Azure) and the service-specific engines (resource providers) enforce different layers of rules.

---

## Summary

**Azure = the orchestrator**  
**Resource providers = the implementers**

Azure handles policies, identity, RBAC, and overall coordination.  
Resource providers enforce their own technical rules and constraints.

Together, they determine whether a deployment succeeds or fails.
