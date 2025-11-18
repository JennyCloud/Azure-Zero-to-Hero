# Lab 01 - Monitor Resources in Azure
## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Monitor and maintain Azure resources (10–15%)**

Monitor resources in Azure
- Interpret metrics in Azure Monitor
- Configure log settings in Azure Monitor
- Query and analyze logs in Azure Monitor
- Set up alert rules, action groups, and alert processing rules in Azure Monitor
- Configure and interpret monitoring of virtual machines, storage accounts, and networks by using Azure Monitor Insights
- Use Azure Network Watcher and Connection Monitor

## What Azure Administrators Do in Real Work
Azure monitoring isn’t a checklist in real life — it’s more like running a control room.  
Admins don’t click through every blade; they build a **monitoring culture** where signals flow, alerts mean something, and dashboards tell the truth.

Here’s how it actually works in the field, spoken plainly and without the certification-polish.

### 1. Admins rarely use the portal for monitoring
The portal is good for demos and labs.  
Real work uses:

- Azure Monitor Workbooks (custom dashboards)  
- Log Analytics Kusto queries  
- Grafana dashboards  
- Azure Monitor Templates in IaC  
- Alerts and logs wired automatically via ARM/Bicep/Terraform

Most production systems have monitoring deployed with code(bicep):

resource alertRule 'microsoft.insights/metricalerts@2023-01-01' = {
  name: 'highCpu'
  properties: {
    criteria: {
      metricName: 'Percentage CPU'
      operator: 'GreaterThan'
      threshold: 80
    }
  }
}

Nobody clicks 40 times to add the same alert to 200 VMs.

### 2. Admins unify everything through Log Analytics + KQL
Log Analytics is the “brain.”  
Admins dump everything there:

- VM logs  
- Storage logs  
- App Service logs  
- Firewall logs  
- API Management logs  
- Custom logs  
- Network flow logs  

Then they query it like a data scientist(KQL):

Syslog  
| where SeverityLevel > 3  
| project TimeGenerated, HostName, Facility, SeverityLevel, SyslogMessage

KQL becomes a daily language.

### 3. Admins use Alerts carefully — too many alerts = useless
Alert fatigue is real.

Admins create:
- few but meaningful alerts  
- mapped to real business impact  
- not “CPU > 50%” noise

Typical production alerts:

- VM unreachable > 10 min  
- App Service HTTP 5xx > 1%  
- Storage latency > threshold  
- Firewall deny spikes  
- Billing anomaly > X%  
- Key Vault secret expiring soon

Then they deliver them through:

- Teams channel  
- PagerDuty  
- Slack  
- Email for low-priority

They do NOT create noisy alerts like:
- CPU > 10  
- Disk queue > 1  
- Everything logs at Severity = Informational

Real admins tune alerts like a musician tunes a guitar.

### 4. Admins rely on Dashboards (Workbooks)
Workbooks give you:

- charts  
- tables  
- maps  
- aggregated queries  

Admins create Workbooks like:

- "VM Fleet Health"  
- "Network Latency Overview"  
- "Application Performance Top Issues"  
- "Storage IOPS & Errors"  

These run on top of KQL and save hours of clicking.

### 5. Admins automate onboarding of monitoring
When a new VM or App Service is deployed, the pipeline auto-attaches:

- Azure Monitor Agent (AMA)  
- Data Collection Rules (DCR)  
- Diagnostic Settings  
- Alerts  

Nobody does this manually for every resource.

In real-world IaC pipelines:

- A Bicep module binds resources to a DCR  
- Another module sets Diagnostic Settings  
- Another deploys baseline alerts

Everything is repeatable.

### 6. Admins troubleshoot with Network Watcher
In real life, Network Watcher tools are used daily:

- Effective NSG rules  
- IP Flow Verify (is this port allowed?)  
- Packet capture  
- Connection Monitor  
- Next hop diagnostics  
- VPN/ExpressRoute troubleshooting

Instead of guessing “why can’t VM A reach VM B,” they run:

az network watcher test-ip-flow --direction Outbound --protocol TCP --port 443 ...

Azure tells the truth in 2 seconds.

### 7. Admins investigate incidents using logs, not feelings
When something breaks:

- Start with Activity Log (did someone delete or modify something?)  
- Check VM Logs / Syslog  
- Check App Insights Traces  
- Check Network Logs  
- Check Storage Insights  
- Run KQL to find anomalies  
- Build a timeline  

Then create root cause analysis (RCA).

### 8. Admins use Monitoring to prevent outages, not just detect them
Good monitoring answers:

- What’s normal?  
- What’s trending up?  
- What’s going to break next week?  
- Is my app leaking memory?  
- Why is this VM suddenly talking to the internet?  
- Did a deployment create a spike in 5xx errors?

Monitoring isn’t passive — it predicts.

### 9. Admins tag everything
Because alerts, logs, and dashboards group by tags:

- env = prod  
- app = billing  
- team = data  
- costcenter = 1245  

This makes them:

- search all prod logs  
- alert only “billing” resources  
- visualize only one cost center  
- apply DCRs to specific teams



