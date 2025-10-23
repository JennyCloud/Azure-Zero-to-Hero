| Feature          | **Inbound NAT Rule**         | **Load Balancing Rule**                      |
| ---------------- | ---------------------------- | -------------------------------------------- |
| Sends traffic to | One specific VM              | Multiple VMs (backend pool)                  |
| Purpose          | Admin access (e.g., RDP/SSH) | Distribute user traffic (e.g., web requests) |
| Common port      | Custom (50001, 50002, etc.)  | Common (80, 443, etc.)                       |
