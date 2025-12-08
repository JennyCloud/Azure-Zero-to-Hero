# RA-GRS vs Object Replication (Azure Storage)

RA-GRS and Object Replication both replicate blob data across regions, but they serve completely different purposes.  
If you understand this comparison, AZ-104 questions on storage redundancy become straightforward.

---

## 1. Purpose
| Feature | Purpose |
|--------|---------|
| **RA-GRS** | Provides passive, read-only disaster recovery protection in the paired region. |
| **Object Replication** | Provides active, usable, cross-region or cross-account replication for applications and analytics. |

---

## 2. Accessibility
| Feature | Accessibility |
|--------|---------------|
| **RA-GRS** | Secondary region is **read-only**. No writes allowed. |
| **Object Replication** | Secondary location is **read/write** and fully usable for workloads. |

---

## 3. Control
| Feature | Level of Control |
|--------|------------------|
| **RA-GRS** | Azure automatically replicates the **entire storage account**. No configuration choices. |
| **Object Replication** | You select **which containers** replicate and where. Fine-grained control. |

---

## 4. Granularity
| Feature | Scope |
|--------|-------|
| **RA-GRS** | Account-wide replication. |
| **Object Replication** | Container-level replication only. |

---

## 5. Use Cases
| Feature | Best For |
|--------|----------|
| **RA-GRS** | Disaster recovery, compliance, regional outage protection. |
| **Object Replication** | Global apps, analytics, cross-region ingestion, multi-tenant architectures. |

---

## 6. Consistency
| Feature | Replication Behavior |
|--------|-----------------------|
| **RA-GRS** | Eventually consistent, unpredictable lag. |
| **Object Replication** | Near real-time replication with lower latency. |

---

## 7. Cross-Account Flexibility
| Feature | Flexibility |
|--------|-------------|
| **RA-GRS** | Only replicates within the same storage account to a paired region. |
| **Object Replication** | Can replicate across **different accounts, subscriptions, or tenants**. |

---

## 8. Versioning & Delete Support
| Feature | Versioning |
|--------|-----------|
| **RA-GRS** | Does not replicate blob versions or delete markers. |
| **Object Replication** | Replicates versions, snapshots, and delete markers. |

---

## 9. Failover Behavior
| Feature | Failover Model |
|--------|----------------|
| **RA-GRS** | Secondary becomes primary only after a failover—typically controlled by Microsoft. |
| **Object Replication** | No failover concept; both locations operate independently. |

---

## 10. Architecture Pattern
| Feature | Pattern |
|--------|--------|
| **RA-GRS** | Passive, read-only secondary region for DR. |
| **Object Replication** | Active data distribution for real applications. |

---

## Summary
**RA-GRS = Disaster Recovery protection.**  
**Object Replication = Operational, cross-region replication for active workloads.**
