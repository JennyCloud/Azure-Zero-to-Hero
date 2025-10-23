| Feature      | Load Balancing Rule     | Inbound NAT Rule                 |
| ------------ | ----------------------- | -------------------------------- |
| Purpose      | Distribute user traffic | Give admin access to specific VM |
| Connects to  | Backend Pool (many VMs) | One specific VM                  |
| Typical Port | 80 (HTTP), 443 (HTTPS)  | 50001 → 3389, etc.               |
| Used for     | Websites, apps          | Remote login (RDP/SSH)           |
