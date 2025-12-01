# Local Network Gateway vs VPN Gateway

A Local Network Gateway and a VPN Gateway look like a matched pair in Azure networking, but they play completely different roles. One represents your on-premises network, and the other is the Azure end of the tunnel.  

---

## The clean mental model  
Think of a Site-to-Site VPN as a bridge:

- One side = your on-premises router  
- The other side = Azure’s VPN appliance  

In Azure terms:

**Local Network Gateway = your side**  
**VPN Gateway = Azure’s side**

It’s that simple.

---

## What the Local Network Gateway actually is  
It’s a definition—a representation—of your on-premises network.

It stores:

- Your on-prem public IP (the IP of your physical VPN device)  
- The address spaces behind it (your internal networks: 10.0.0.0/16, 192.168.1.0/24, etc.)  
- Optional BGP settings (ASN, peer IP)  

There is no hardware and no gateway created inside Azure.  
It’s just Azure’s way of saying:

> “Hey, this is the network I’ll be talking to.”

If your on-prem info changes, you update this, not the VPN Gateway.

---

## What the VPN Gateway actually is  
This is a gateway—Azure creates a real, virtualized VPN appliance.

It:

- Runs in a special subnet (`GatewaySubnet`)  
- Is billed as a persistent resource  
- Performs IPsec/IKE encryption/decryption  
- Handles S2S, P2S, and VNet-to-VNet tunnels  
- Can run active-active  
- Can run BGP  
- Supports up to 10–30 Gbps aggregate (depending on SKU)

This is Azure’s counterpart to your physical firewall/router.

---

## Why you need both  
You can’t build a tunnel with only one endpoint.

Azure needs two logical components:

1. The real Azure gateway → VPN Gateway  
2. The description of your router → Local Network Gateway  

Then Azure binds them with a connection object.

---

## How they fit together in a tunnel  
Azure VPN Gateway  
⬇  
Connection (IPsec/IKE policy, shared key, etc.)  
⬇  
Local Network Gateway  
⬇  
Your on-prem VPN device  
⬇  
Your LAN routes

The Local Network Gateway tells Azure where to send packets once they arrive at the tunnel.

---

## Why the naming is confusing  
Because “gateway” makes people think they are the same thing.

Think of it like this:

- VPN Gateway = a real appliance Azure spins up  
- Local Network Gateway = a business card describing your on-prem device  

One is a machine.  
One is metadata.

---

## Tiny analogy  
Azure VPN Gateway = your side of the telephone  
Local Network Gateway = the contact card for the person you’re calling

You need both to complete the call.
