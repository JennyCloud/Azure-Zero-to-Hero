| Feature                   | Flat VNet (1 Subnet)                                  | Tiered Subnet VNet (Web/App/DB)                                     |
| ------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------- |
| **Number of subnets**     | 1                                                     | 3 (or more, per tier)                                               |
| **Default connectivity**  | All VMs can talk freely                               | All VMs can talk freely *unless NSGs or routes are applied*         |
| **Security control**      | Limited; hard to isolate workloads                    | Easy; attach NSGs/firewalls per subnet                              |
| **Service placement**     | Can't host services requiring dedicated subnet easily | Services like Bastion, Firewall, VPN Gateway have their own subnets |
| **IP address management** | Single IP range; less control                         | Each tier has its own IP range; easier to scale                     |
| **Best for**              | Tiny lab / test environment                           | Real-world production / multi-tier apps                             |
