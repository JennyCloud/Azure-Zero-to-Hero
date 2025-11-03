# ⚙️ Azure Container Instances — CPU Requests vs Limits

**Goal:** Understand why removing CPU *limits* in an Azure Container Group can prevent one container from slowing down another.

---

## 🧠 Scenario Overview

You have a container group with two containers:

| Container | CPU Request | CPU Limit |
|:--|:--|:--|
| **container1** | 2 | 2 |
| **container2** | 3 | 4 |

**Problem:**  
`container2` is very busy and uses up all its allowed CPU.  
You want to make sure this doesn’t slow down `container1`.

---

## 🧩 Key Concepts

- **Request:** the *minimum guaranteed* CPU share that Azure always keeps available for that container.
- **Limit:** the *maximum allowed* CPU usage. The container cannot go above this even when spare CPU is available.

Requests = **promised baseline**  
Limits = **hard ceiling**

---

## 🏋️ Gym Analogy

Imagine a gym with **5 treadmills** (the host’s CPUs).

| Person | Minimum treadmills (Request) | Maximum treadmills (Limit) |
|:--|:--|:--|
| **Jenny** (container1) | 2 | 2 |
| **Frank** (container2) | 3 | 4 |

- **Request** = guaranteed access to a certain number of treadmills.
- **Limit** = maximum allowed treadmills.

If Frank uses all 4 treadmills and Jenny comes back,  
the gym manager (the CPU scheduler) must wait for Frank to slow down before giving Jenny her share again.

That short delay = Jenny “waiting.”  
It’s not lost CPU — just a **momentary slowdown** while the scheduler rebalances usage.

---

## 🧱 Case 1: With Limits

Limits create **rigid walls**. Each container is confined to its own maximum box.  
If one is maxed out, the other must wait until slices of CPU time are freed.

CPU Time (simplified)
|FF|FF|FF|FF|JJ|JJ|FF|FF|FF|FF|JJ|JJ|


- “FF” = Frank using 4 CPUs worth of time  
- “JJ” = Jenny using 2 CPUs worth of time  

Jenny can’t use more even if extra CPU is available — her limit forbids it.  
If Frank is constantly busy, she experiences micro-delays before the scheduler reclaims CPU time.

---

## 🌊 Case 2: Without Limits

No artificial caps — only requests.  
Now the scheduler dynamically adjusts CPU time based on real activity.

CPU Time (simplified)
|FF|FF|JJ|FF|JJ|FF|JJ|JJ|FF|JJ|FF|JJ|


- Frank still gets his fair 3-CPU share.  
- Jenny instantly regains her 2 CPUs when she needs them.  
- If one container idles, the other can use the leftover CPU immediately.  

**Elastic scheduling = smoother performance + better efficiency.**

---

## ⚖️ Comparison Table

| Concept | With Limits | Without Limits |
|:--|:--|:--|
| CPU Access | Fixed maximum | Dynamic, shared fairly |
| Scheduler Flexibility | Low | High |
| Performance Fairness | Possible delays | Instant balance |
| Resource Efficiency | May waste idle CPU | Uses all available CPU |

---

## 💡 Takeaway

- **Requests** protect each container’s minimum guaranteed CPU.  
- **Limits** restrict flexibility and can cause short delays when workloads change.  
- **Removing limits** allows Azure’s scheduler to instantly rebalance CPU time, ensuring both containers perform smoothly without contention.

✅ **Best answer:** Remove the resource limits for both containers.

---

### 📘 Extra Tip

This concept mirrors **Kubernetes’ CPU scheduling model**,  
where removing `limits` while keeping `requests` gives workloads elasticity without starvation.
