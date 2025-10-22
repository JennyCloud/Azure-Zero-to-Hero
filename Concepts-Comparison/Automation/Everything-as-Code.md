# Infrastructure as Code (IaC)

## 🧩 What Is IaC?
**Infrastructure as Code (IaC)** is a modern way to manage and provision cloud infrastructure using **code or configuration files** instead of manual setup through the Azure Portal.

With IaC, you define your infrastructure — such as virtual machines, networks, and storage — in a **template or script**, and Azure automatically deploys it based on your code.  
This makes your environment **repeatable, consistent, and version-controlled**.

---

## 🔄 Comparison
| **Concept**                          | **How It Relates / Differs from IaC**                                                                                                                              | **Purpose**                                      |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------ |
| **Configuration as Code (CaC)**      | Focuses on configuring the *software* inside servers (like installing IIS or setting app settings), while IaC sets up the *infrastructure* (VMs, networks, disks). | Manages software configuration and system state. |
| **Policy as Code (PaC)**             | Defines governance and compliance rules as code (e.g., Azure Policy). Works *with* IaC to ensure deployments follow standards.                                     | Enforces security and compliance automatically.  |
| **Pipeline as Code**                 | Defines your CI/CD pipelines as code (e.g., GitHub Actions, Azure DevOps YAML). Often used to deploy IaC templates automatically.                                  | Automates builds, tests, and deployments.        |
| **Immutable Infrastructure**         | IaC often supports this — instead of changing a running server, you replace it with a new one from code.                                                           | Ensures clean, consistent environments.          |
| **Manual Deployment (Portal / CLI)** | The traditional approach — clicking in the portal or typing ad-hoc commands. IaC replaces this with automated, repeatable code-based deployment.                   | Quick setup, but not repeatable or scalable.     |

---

# 🧠 Key Takeaway

IaC is part of a bigger “Everything as Code” movement — where infrastructure, configuration, policy, and pipelines are all defined and automated through code.
  }
}
