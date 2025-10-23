| Session Persistence      | Use Case                                    | Example                             |
| ------------------------ | ------------------------------------------- | ----------------------------------- |
| **None**                 | Stateless app, no session stickiness needed | Static site or API backend          |
| **Client IP**            | Need to stick users to same VM              | Web app with session data in memory |
| **Client IP + Protocol** | Same as above, but want TCP/UDP separation  | Apps using multiple protocols       |
