# Understanding KQL Syntax (Foundations)

Kusto Query Language—KQL—is the language used by Microsoft Entra logs, Azure Monitor Logs, Log Analytics workspaces, Application Insights, Defender, Sentinel, and anything that stores data in the Azure Data Explorer engine.

The trick is to think in *pipelines* (just like PowerShell). Every line takes the previous line’s output and refines it.

## 1. Tables are the starting point
KQL always begins with the name of a **table**.

Examples:  
`SigninLogs`  
`Heartbeat`  
`AzureActivity`  
`SecurityEvent`  
`Perf`

A simple query:

SigninLogs


KQL reads top to bottom, one operator at a time.

---

## 2. The Pipe `|`
The pipe connects operations.

SigninLogs
| take 10


Read this as: *Take the SigninLogs table, then take 10 rows.*

---

## 3. Filtering with `where`

SigninLogs
| where ResultType == 0


Common operators:

- `==`
- `!=`
- `contains`
- `startswith`
- `has`
- `in`

Example:

AzureActivity
| where OperationNameValue contains "Write"
| where ActivityStatusValue == "Success"


---

## 4. Selecting columns with `project`

SigninLogs
| project UserPrincipalName, IPAddress, AppDisplayName


---

## 5. Creating columns with `extend`

SigninLogs
| extend Device = tostring(DeviceDetail.browser)
| project UserPrincipalName, Device


---

## 6. Sorting with `order by`

SigninLogs
| order by TimeGenerated desc


---

## 7. Counting with `summarize`

SigninLogs
| summarize count() by UserPrincipalName
| order by count_ desc


Time-based counts:

SigninLogs
| summarize count() by bin(TimeGenerated, 1h)


---

## 8. Joining tables with `join`

SecurityEvent
| where EventID == 4624
| join kind=inner (
Heartbeat
) on Computer


---

## 9. Parsing with `parse` and `extract`

AppTraces
| parse Message with "User " username " logged in from " ip


---

## 10. Time ranges with `ago()`

SigninLogs
| where TimeGenerated > ago(24h)


Or:

where TimeGenerated between (ago(7d) .. now())


---

## 11. Real-world KQL pattern

SigninLogs
| where TimeGenerated > ago(1d)
| where ResultType == 0
| project UserPrincipalName, IPAddress, AppDisplayName, TimeGenerated
| order by TimeGenerated desc


Security-focused:

SecurityEvent
| where EventID in (4625, 4624)
| extend LoginType = iff(EventID == 4624, "Success", "Fail")
| summarize count() by LoginType, bin(TimeGenerated, 1h)


---

## 12. How to “think like KQL”

1. Start with a table  
2. Filter with where  
3. Shape with project/extend  
4. Group with summarize  
5. Sort or visualize  

Always a funnel: big → small → meaningful.

---

## 13. Mental trick

SQL: rows control everything  
KQL: logs flow like rivers  

---

## 14. What comes next?

- Types & data structures  
- Let statements  
- Advanced joins  
- Case-insensitive text search  
- Time series with make-series  
- JSON & array parsing  
- Sentinel security queries  
- Differences between Azure Monitor & App Insights KQL

Next natural topic: **KQL functions & let statements**.
