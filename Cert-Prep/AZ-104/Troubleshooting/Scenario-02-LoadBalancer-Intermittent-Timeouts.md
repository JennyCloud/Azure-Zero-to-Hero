# Troubleshooting Scenario #2 — Load Balancer: intermittent timeouts

## Situation
Your web app is running on two VMs behind a **Public Load Balancer**. Users report that sometimes pages load, sometimes they hang, and occasionally they get timeouts.

Classic “intermittent” symptom.

You need to figure out what’s causing the inconsistent behavior.

---

## How to think about it

Azure Load Balancers are very honest creatures — they only send traffic to **healthy** backend instances.

If a health probe fails even once, the VM is considered unhealthy and is removed from rotation.

So intermittent timeouts almost always mean:

- The load balancer can’t consistently reach your VM.
- Or your VM can’t consistently answer the health probe.

This leads to a VM bouncing in and out of the backend pool like a faulty Christmas light.

---

## What commonly breaks LB health probes

1. **NSG blocking the probe traffic**  
   Health probes originate from the `AzureLoadBalancer` service tag.  
   If inbound rules don’t allow this tag → probe fails.

2. **The service on the VM not responding on the probe port**  
   Example: Probe port = 80  
   Your web service is listening on 8080  
   → LB sees “no response” → removes VM.

3. **Application is slow or overloaded**  
   If the probe expects a reply within 5 seconds but your service responds in 8 seconds → fail.

4. **Probe misconfiguration**  
   Wrong path (for HTTP probes)  
   Wrong port  
   Wrong protocol (TCP vs HTTP)

---

## How to solve it

### 1. Check the health probe status
Load Balancer → Backend Pool → Health probe status  
If one VM is “Unhealthy,” you’ve caught the culprit.

### 2. Check NSG rules
Confirm inbound allow rule exists:
- Source: `AzureLoadBalancer`
- Port: probe port
- Target: VM

### 3. Validate the VM service answers on the probe port
RDP/SSH into the VM.

Run:
- `curl http://localhost:80` (for HTTP probe)
- or `Test-NetConnection` in Windows

If the web server isn't responding, the LB is correct to mark the VM unhealthy.

### 4. Check the health probe configuration
Look for:
- Wrong paths
- Wrong ports
- Wrong protocol

### 5. Check VM performance
High CPU or memory can cause intermittent probe failures.  
Intermittent failures = intermittent unhealthy states.

---

# Why follow these steps?

Traffic through a load balancer follows a strict, mechanical sequence. Troubleshooting in the same order keeps you aligned with how Azure decides **“Is this VM healthy or not?”**

---

## Why this exact troubleshooting sequence works

### 1. Health probe status first — because it tells you WHERE to look
The load balancer already knows which VM is misbehaving.  
Checking probe status prevents you from fixing the wrong machine.

---

### 2. NSG rules second — because they are the first physical barrier
The health probe is like a tiny Azure robot trying to reach the VM.  
If the NSG blocks the robot, the VM fails the probe immediately.  
This must be checked before deeper application issues.

---

### 3. VM service check third — because even if the probe arrives, your app must answer
If your app is slow, on the wrong port, or crashed, the probe sees silence and marks it unhealthy.  
This step validates whether the VM is the true culprit.

---

### 4. Probe configuration next — because the load balancer may be asking the wrong question
You check this only after confirming the VM and NSG are fine.  
Misconfig (wrong port/path/protocol) causes healthy VMs to appear unhealthy.

---

### 5. VM performance last — because it affects consistency, not connectivity
Performance issues cause intermittent failures, matching the symptom:  
“sometimes works, sometimes doesn’t.”  
Checking this last avoids misdiagnosis.

---

## Why the order matters
Azure networking is a chain of gates:

1. Probe must reach VM (NSG)  
2. VM must respond (service)  
3. LB must be correctly configured (probe settings)  
4. VM must handle load (performance)

If you check out of order, symptoms mislead you and you waste time chasing ghosts.

---

## The deeper truth
Azure doesn’t troubleshoot from symptoms — it troubleshoots from the **actual packet journey**.

Following these steps aligns your brain with how Azure evaluates traffic and health, making the behavior predictable and logical.
